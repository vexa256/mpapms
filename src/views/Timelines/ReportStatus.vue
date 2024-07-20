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
                  v-model="currentReport.Status"
                  required
                >
                  <option value="Active">Active</option>
                  <option value="Disabled">Disabled</option>
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
export default {
  name: "ReportStatusManagement",
  data() {
    return {
      reports: [],
      currentReport: {},
      isModalOpen: false,
    };
  },
  methods: {
    LoadDataTables() {
      setTimeout(function () {
        $("table").DataTable({
          responsive: true,
          dom: "Bfrtip",
          buttons: ["copy", "csv", "excel", "pdf", "print"],
        });
      }, 1000);
    },
    fetchReports() {
      // Ensure proper table name and data handling as per the original setup
      this.$axios
        .post(`${window.SERVER_URL}MassFetch`, {
          TableName: "reporting_timelines", // Make sure this matches exactly with your backend expectation
          ExcludeColumns: [], // This was missing in your modified version and could be causing the issue if your backend expects it
        })
        .then((response) => {
          this.reports = response.data.data;
        })
        .catch((error) => {
          console.error("Error fetching reports:", error);
        });
    },
    showModal(open, report) {
      this.isModalOpen = open;
      this.currentReport = { ...report };
    },
    submitForm() {
      const url = `${window.SERVER_URL}MassUpdate`;
      const payload = {
        ...this.currentReport,
        TableName: "reporting_timelines", // Again, ensure this matches your backend's expectations
      };
      this.$axios
        .post(url, payload)
        .then(() => {
          Swal.fire("Success", "Report status updated successfully", "success");
          this.fetchReports(); // Refresh list
        })
        .catch((error) => {
          console.error("Error updating report status:", error);
        })
        .finally(() => {
          this.showModal(false, {});
        });
    },
  },
  created() {
    this.fetchReports();
    this.LoadDataTables();
  },
};
</script>
