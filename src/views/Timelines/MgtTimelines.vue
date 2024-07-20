<template>
  <div class="row">
    <FullScreenLoader />
    <div class="card-body pt-3 fw-bolder text-white shadow-lg table-responsive">
      <div class="alert alert-primary shadow-lg">
        <!--begin::Icon-->
        <span class="float-end svg-icon svg-icon-2hx svg-icon-primary me-3">
          <i class="fas fa-info fa-2x" aria-hidden="true"></i>
        </span>
        <!--end::Icon-->

        <!--begin::Wrapper-->
        <div class="d-flex flex-column">
          <!--begin::Title-->
          <h4 class="mb-1 text-dark">Reporting Timelines Database</h4>
          <!--end::Title-->
          <!--begin::Content-->
          <span
            >Add and remove reporting timelines that report on indicators</span
          >
          <!--end::Content-->
        </div>
        <!--end::Wrapper-->
      </div>
      <!--end::Alert-->
    </div>
    <div class="row mb-3">
      <div class="col-12 text-end">
        <button
          @click="showModal(true, {})"
          type="button"
          class="btn mx-1 float-end mb-2 btn-sm btn-danger"
        >
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
              <td class="bg-dark text-light fw-bolder">
                {{ timeline.ReportName }}
              </td>
              <td class="bg-primary text-light fw-bolder">
                {{ timeline.Type }}
              </td>
              <td class="bg-warning text-dark fw-bolder">
                {{ timeline.Description }}
              </td>
              <td class="bg-primary text-light fw-bolder">
                {{ timeline.RID }}
              </td>
              <td class="bg-warning text-dark fw-bolder">
                {{ timeline.Year }}
              </td>
              <td>
                <div class="d-flex justify-content-end">
                  <a
                    href="#"
                    class="btn btn-sm btn-warning text-dark fw-bolder me-2"
                    @click="showModal(true, timeline)"
                  >
                    <i class="ki ki-pencil fs-3"></i>
                    <span class="indicator-label">Edit</span>
                  </a>
                  <a
                    href="#"
                    class="btn btn-sm btn-danger me-2"
                    @click="confirmDelete(timeline)"
                  >
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

    <!-- Modal for Add/Edit -->
    <div v-if="isModalOpen" class="modal fade show d-block" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">
              {{ currentTimeline.id ? "Edit Report" : "Add Report" }}
            </h5>
            <button
              type="button"
              class="btn-close"
              @click="showModal(false, {})"
            ></button>
          </div>
          <div class="modal-body">
            <form @submit.prevent="submitForm">
              <div class="mb-3">
                <label for="ReportName" class="form-label">Report Name</label>
                <input
                  type="text"
                  class="form-control"
                  v-model="currentTimeline.ReportName"
                  required
                />
              </div>
              <div class="mb-3">
                <label for="Type" class="form-label">Type</label>
                <select
                  data-kt-select2="true"
                  class="form-control select2"
                  v-model="currentTimeline.Type"
                  required
                >
                  <option value="Annual Report">Annual Report</option>
                  <option value="Bi-Annual Report">Bi-Annual Report</option>
                  <option value="Quarterly Report">Quarterly Report</option>
                </select>
              </div>
              <div class="mb-3">
                <label for="Year" class="form-label">Year</label>
                <select
                  data-kt-select2="true"
                  class="form-control select2"
                  v-model="currentTimeline.Year"
                  required
                >
                  <option v-for="year in years" :key="year" :value="year">
                    {{ year }}
                  </option>
                </select>
              </div>
              <div class="mb-3">
                <label for="Description" class="form-label">Description</label>
                <textarea
                  class="form-control"
                  v-model="currentTimeline.Description"
                  required
                ></textarea>
              </div>

              <button type="submit" class="btn btn-primary">
                {{ currentTimeline.id ? "Update" : "Add" }} Report
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
  name: "ReportingTimelinesManagement",
  data() {
    return {
      reportingTimelines: [],
      currentTimeline: {},
      isModalOpen: false,
      years: Array.from({ length: 10 }, (v, i) => 2024 + i),
    };
  },
  methods: {
    initializeSelect2() {
      // Wait until the DOM is fully loaded
    },
    LoadDataTables() {
      setTimeout(function () {
        $("table").DataTable({
          responsive: true,
          dom: "Bfrtip",
          buttons: ["copy", "csv", "excel", "pdf", "print"],
        });
      }, 1000);
    },
    fetchReportingTimelines() {
      this.$axios
        .post(`${window.SERVER_URL}MassFetch`, {
          TableName: "reporting_timelines",
          ExcludeColumns: [],
        })
        .then((response) => {
          this.reportingTimelines = response.data.data;
        })
        .catch((error) => {
          console.error("Error fetching reporting timelines:", error);
        });
    },
    showModal(open, timeline) {
      this.isModalOpen = open;
      this.currentTimeline = { ...timeline };
    },
    submitForm() {
      const url = this.currentTimeline.id
        ? `${window.SERVER_URL}MassUpdate`
        : `${window.SERVER_URL}MassInsert`;
      const payload = {
        ...this.currentTimeline,
        TableName: "reporting_timelines",
      };
      this.$axios
        .post(url, payload)
        .then(() => {
          Swal.fire(
            "Success",
            "Report has been processed successfully",
            "success"
          );
          this.fetchReportingTimelines();
        })
        .catch((error) => {
          console.error("Error processing report:", error);
        })
        .finally(() => {
          this.showModal(false, {});
        });
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
    deleteTimeline(id) {
      this.$axios
        .delete(`${window.SERVER_URL}MassDelete/reporting_timelines/${id}`)
        .then(() => {
          Swal.fire("Deleted!", "Your report has been deleted.", "success");
          this.fetchReportingTimelines();
        })
        .catch((error) => {
          console.error("Error deleting report:", error);
        });
    },
  },
  created() {
    this.fetchReportingTimelines();
  },
  mounted() {
    this.LoadDataTables();
    this.initializeSelect2();
  },
};
</script>

<style scoped>
.modal.fade.show {
  display: block;
  background: rgba(0, 0, 0, 0.5);
}

.btn.material-btn-edit,
.btn.material-btn-delete {
  border: none;
  border-radius: 50%;
  color: #fff;
  padding: 8px 8px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
  transition: box-shadow 0.3s, background-color 0.3s;
}

.btn.material-btn-edit {
  background-color: #1976d2;
}

.btn.material-btn-edit:hover,
.btn.material-btn-edit:focus {
  background-color: #135ba1;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
}

.btn.material-btn-delete {
  background-color: #d32f2f;
}

.btn.material-btn-delete:hover,
.btn.material-btn-delete:focus {
  background-color: #a12323;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
}
</style>
