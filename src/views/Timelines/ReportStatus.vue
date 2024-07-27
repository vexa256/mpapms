<template>
  <div class="row">
    <FullScreenLoader />
    <div class="card-body pt-3 fw-bolder text-white shadow-lg table-responsive">
      <div class="alert alert-primary shadow-lg">
        <span class="float-end svg-icon svg-icon-2hx svg-icon-primary me-3">
          <i class="fas fa-info fa-2x" aria-hidden="true"></i>
        </span>
        <div class="d-flex flex-column">
          <h4 class="mb-1 text-dark">Reporting Timeline Status Management</h4>
          <span>Update the status of the Reporting Timeline</span>
        </div>
      </div>
    </div>
    <div class="row mb-3">
      <div class="col-12 text-end">
        <!-- No New Report Button as only status update is required -->
      </div>
    </div>
    <div class="col-12">
      <div class="card-body px-5 py-5 bg-light shadow-lg table-responsive">
        <table class="table table-rounded table-bordered border gy-3 gs-3">
          <thead>
            <tr class="fw-bold text-gray-800 border-bottom border-gray-200">
              <th class="bg-dark text-light fw-bolder">Report Name</th>
              <th class="bg-warning text-dark fw-bolder">Status</th>
              <th class="bg-primary text-light fw-bolder">Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="report in reports" :key="report.id">
              <td class="bg-dark text-light fw-bolder">
                {{ report.ReportName }}
              </td>
              <td class="bg-warning text-dark fw-bolder">
                {{ report.status }}
              </td>
              <td>
                <div class="d-flex justify-content-end">
                  <button
                    class="btn btn-sm btn-primary"
                    @click="showModal(true, report)"
                  >
                    <i class="ki ki-pencil fs-3"></i>
                    Update Status
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <!-- Modal for Status Update -->
    <div v-if="isModalOpen" class="modal fade show d-block" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Update Report Status</h5>
            <button
              type="button"
              class="btn-close"
              @click="showModal(false, {})"
            ></button>
          </div>
          <div class="modal-body">
            <form @submit.prevent="submitForm">
              <div class="mb-3">
                <label for="Status" class="form-label">Status</label>
                <select
                  class="form-control"
                  v-model="currentReport.status"
                  required
                >
                  <option value="active">Active</option>
                  <option value="disabled">Disabled</option>
                </select>
              </div>
              <button type="submit" class="btn btn-primary my-5">
                Update Status
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import pb from "../../pocketbase";
import Swal from "sweetalert2";
import FullScreenLoader, {
  isLoading,
} from "../../components/FullScreenLoader.vue";

export default {
  name: "ReportStatusManagement",
  components: {
    FullScreenLoader,
  },
  data() {
    return {
      reports: [],
      currentReport: {
        ReportName: "",
        status: "active",
      },
      isModalOpen: false,
    };
  },
  methods: {
    async fetchReports() {
      isLoading.value = true;
      try {
        const resultList = await pb
          .collection("mpa_reporting_timelines")
          .getFullList({
            sort: "-created",
          });
        this.reports = resultList;
      } catch (error) {
        console.error("Error fetching reports:", error);
        Swal.fire("Error", "Error fetching reports: " + error.message, "error");
      } finally {
        isLoading.value = false;
      }
    },
    showModal(open, report) {
      this.isModalOpen = open;
      this.currentReport = { ...report };
    },
    async submitForm() {
      isLoading.value = true;
      try {
        await pb
          .collection("mpa_reporting_timelines")
          .update(this.currentReport.id, {
            status: this.currentReport.status,
          });
        Swal.fire("Success", "Report status updated successfully", "success");
        this.fetchReports();
      } catch (error) {
        console.error("Error updating report status:", error.message);
        Swal.fire(
          "Error",
          "Error updating report status: " + error.message,
          "error"
        );
      } finally {
        this.showModal(false, {});
        isLoading.value = false;
      }
    },
  },
  created() {
    this.fetchReports();
  },
};
</script>

<style scoped>
.modal.fade.show {
  display: block;
  background: rgba(0, 0, 0, 0.5);
}
</style>
