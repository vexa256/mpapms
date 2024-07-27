<template>
  <div class="row">
    <FullScreenLoader />
    <div class="card-body pt-3 fw-bolder text-white shadow-lg table-responsive">
      <div class="alert alert-primary shadow-lg">
        <span class="float-end svg-icon svg-icon-2hx svg-icon-primary me-3">
          <i class="fas fa-info fa-2x" aria-hidden="true"></i>
        </span>
        <div class="d-flex flex-column">
          <h4 class="mb-1 text-dark">Reporting Timelines Database</h4>
          <span>Add and remove reporting timelines that report on indicators</span>
        </div>
      </div>
    </div>
    <div class="row mb-3">
      <div class="col-12 text-end">
        <button @click="showModal(true, {})" type="button" class="btn mx-1 float-end mb-2 btn-sm btn-danger">
          <i class="fas me-1 fa-plus" aria-hidden="true"></i>New Report
        </button>
      </div>
    </div>
    <div class="col-12">
      <div class="card-body px-5 py-5 bg-light shadow-lg table-responsive">
        <table class="table table-rounded table-bordered border gy-3 gs-3">
          <thead>
            <tr class="fw-bold text-gray-800 border-bottom border-gray-200">
              <th class="bg-dark text-light fw-bolder">Report Name</th>
              <th class="bg-primary text-light fw-bolder">Type</th>
              <th class="bg-warning text-dark fw-bolder">Description</th>
              <th class="bg-primary text-light fw-bolder">RID</th>
              <th class="bg-warning text-dark fw-bolder">Year</th>
              <th class="bg-warning text-dark fw-bolder">Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="timeline in reportingTimelines" :key="timeline.id">
              <td class="bg-dark text-light fw-bolder">{{ timeline.ReportName }}</td>
              <td class="bg-primary text-light fw-bolder">{{ timeline.Type }}</td>
              <td class="bg-warning text-dark fw-bolder">{{ timeline.Description }}</td>
              <td class="bg-primary text-light fw-bolder">{{ timeline.ReportingID }}</td>
              <td class="bg-warning text-dark fw-bolder">{{ timeline.Year }}</td>
              <td>
                <div class="d-flex justify-content-end">
                  <a href="#" class="btn btn-sm btn-warning text-dark fw-bolder me-2" @click="showModal(true, timeline)">
                    <i class="ki ki-pencil fs-3"></i>
                    <span class="indicator-label">Edit</span>
                  </a>
                  <a href="#" class="btn btn-sm btn-danger me-2" @click="confirmDelete(timeline)">
                    <i class="ki ki-trash fs-3"></i>
                    <span>Delete</span>
                  </a>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div v-if="isModalOpen" class="modal fade show d-block" id="LogicModal">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ currentTimeline.id ? "Edit Report" : "Add Report" }}</h5>
            <button type="button" class="btn-close" @click="showModal(false, {})"></button>
          </div>
          <div class="modal-body">
            <form @submit.prevent="submitForm">
              <div class="mb-3">
                <label for="ReportName" class="form-label">Report Name</label>
                <input type="text" class="form-control" v-model="currentTimeline.ReportName" required />
              </div>
              <div class="mb-3">
                <label for="Type" class="form-label">Type</label>
                <select data-kt-select2="true" class="form-control select2" v-model="currentTimeline.Type" required>
                  <option value="Annual Report">Annual Report</option>
                  <option value="Bi-Annual Report">Bi-Annual Report</option>
                  <option value="Quarterly Report">Quarterly Report</option>
                </select>
              </div>
              <div class="mb-3">
                <label for="Year" class="form-label">Year</label>
                <select data-kt-select2="true" class="form-control select2" v-model="currentTimeline.Year" required>
                  <option v-for="year in years" :key="year" :value="year">{{ year }}</option>
                </select>
              </div>
              <div class="mb-3">
                <label for="Description" class="form-label">Description</label>
                <textarea class="form-control" v-model="currentTimeline.Description" required></textarea>
              </div>
              <button type="submit" class="btn btn-primary">{{ currentTimeline.id ? "Update" : "Add" }} Report</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import pb from '../../pocketbase';
import Swal from 'sweetalert2';
import FullScreenLoader, { isLoading } from '../../components/FullScreenLoader.vue';

export default {
  name: "ReportingTimelinesManagement",
  components: {
    FullScreenLoader
  },
  data() {
    return {
      reportingTimelines: [],
      currentTimeline: {
        ReportName: '',
        Type: '',
        Description: '',
        ReportingID: '',
        Year: '',
        status: 'active' // Default value for status
      },
      isModalOpen: false,
      years: Array.from({ length: 10 }, (v, i) => 2024 + i),
    };
  },
  methods: {
    async fetchReportingTimelines() {
      isLoading.value = true;
      try {
        const resultList = await pb.collection('mpa_reporting_timelines').getFullList({
          sort: '-created',
        });
        this.reportingTimelines = resultList;
      } catch (error) {
        console.error("Error fetching reporting timelines:", error);
        Swal.fire("Error", "Error fetching reporting timelines: " + error.message, "error");
      } finally {
        isLoading.value = false;
      }
    },
    showModal(open, timeline) {
      this.isModalOpen = open;
      this.currentTimeline = { ...timeline, status: 'active' }; // Ensure status defaults to 'active'
      if (!this.currentTimeline.ReportingID) {
        this.currentTimeline.ReportingID = this.generateReportingID();
      }
    },
    generateReportingID() {
      return Math.floor(Date.now() / 1000); // Unix timestamp in seconds
    },
    async submitForm() {
      console.log("Form Data:", this.currentTimeline);
      isLoading.value = true;
      try {
        if (this.currentTimeline.id) {
          await pb.collection('mpa_reporting_timelines').update(this.currentTimeline.id, this.currentTimeline);
        } else {
          await pb.collection('mpa_reporting_timelines').create(this.currentTimeline);
        }
        Swal.fire("Success", "Report has been processed successfully", "success");
        this.fetchReportingTimelines();
      } catch (error) {
        console.error("Error submitting form:", error);
        Swal.fire("Error", "Error submitting form: " + error.message, "error");
      } finally {
        this.showModal(false, {});
        isLoading.value = false;
      }
    },
    async deleteTimeline(id) {
      isLoading.value = true;
      try {
        await pb.collection('mpa_reporting_timelines').delete(id);
        Swal.fire("Deleted!", "Your report has been deleted.", "success");
        this.fetchReportingTimelines();
      } catch (error) {
        console.error("Error deleting report:", error);
        Swal.fire("Error", "Error deleting report: " + error.message, "error");
      } finally {
        isLoading.value = false;
      }
    },
    confirmDelete(timeline) {
      Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!",
      }).then((result) => {
        if (result.isConfirmed) {
          this.deleteTimeline(timeline.id);
        }
      });
    },
  },
  created() {
    this.fetchReportingTimelines();
  },
};
</script>


<style scoped>
.modal.fade.show {
  display: block;
  background: rgba(0, 0, 0, 0.5);
}
</style>
