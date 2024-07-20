<template>
  <div class="row">
    <FullScreenLoader v-if="loading" />
    <div
      v-if="!loading"
      class="card-body pt-3 fw-bolder text-white shadow-lg table-responsive"
    >
      <div class="alert alert-primary shadow-lg">
        <span class="float-end svg-icon svg-icon-2hx svg-icon-primary me-3">
          <i class="fas fa-info fa-2x" aria-hidden="true"></i>
        </span>
        <div class="d-flex flex-column">
          <h4 class="mb-1 text-dark">
            Manage Project Indicators
            <span class="fw-bolder text-danger">
              for the entity {{ this.Entity }}</span
            >
          </h4>
          <span>View and edit project indicators</span>
        </div>
      </div>
    </div>
    <div class="row mb-3">
      <div class="col-12 text-end">
        <button
          @click="openAddModal"
          type="button"
          class="btn mx-1 float-end mb-2 btn-sm btn-danger"
        >
          <i class="fas me-1 fa-plus" aria-hidden="true"></i>New Indicator
        </button>
      </div>
    </div>
    <div class="col-12 mt-3">
      <div class="card-body px-5 py-5 bg-light shadow-lg table-responsive">
        <table class="table table-rounded table-bordered border gy-3 gs-3">
          <thead>
            <tr class="fw-bold text-gray-800 border-bottom border-gray-200">
              <th>Primary Category</th>
              <th>Secondary Category</th>
              <th>Entity</th>
              <th>Indicator</th>
              <th>Definition</th>
              <th>Question</th>
              <th>Remarks/Comments</th>
              <th>Response Type</th>
              <th>Reporting Period</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="indicator in indicators" :key="indicator.id">
              <td>{{ indicator.IndicatorPrimaryCategory }}</td>
              <td>{{ indicator.IndicatorSecondaryCategory }}</td>
              <td>{{ indicator.Entity }}</td>
              <td>{{ indicator.Indicator }}</td>
              <td>{{ indicator.IndicatorDefinition }}</td>
              <td>{{ indicator.IndicatorQuestion }}</td>
              <td>{{ indicator.RemarksComments }}</td>
              <td>{{ indicator.ResponseType }}</td>
              <td>{{ indicator.ReportingPeriod }}</td>
              <td>
                <div class="d-flex justify-content-end">
                  <button
                    class="btn btn-sm btn-dark text-dark fw-bolder me-2"
                    @click="openUpdateModal(indicator)"
                  >
                    <i class="fas fa-pencil fs-3"></i>
                  </button>
                  <button
                    class="btn btn-sm btn-danger me-2"
                    @click="confirmDelete(indicator)"
                  >
                    <i class="fas fa-trash fs-3"></i>
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Add Modal -->
    <div
      v-if="showAddForm"
      class="modal fade show d-block"
      id="addIndicatorModal"
      tabindex="-1"
    >
      <div class="modal-dialog modal-fullscreen">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Add New Indicator</h5>
            <button
              type="button"
              class="btn-close"
              @click="closeAddModal"
            ></button>
          </div>
          <div class="modal-body">
            <form ref="addForm" @submit.prevent="submitAddForm">
              <div class="row">
                <div class="mb-3 col-md-3">
                  <label for="ResponseType" class="px-5 required form-label"
                    >Indicator Response Category</label
                  >
                  <select
                    id="ResponseType"
                    name="ResponseType"
                    class="form-select"
                    v-model="newIndicator.ResponseType"
                    required
                  >
                    <option value="" disabled>Select an option</option>
                    <option value="Yes/No">Yes/No</option>
                    <option value="Percentage">Percentage</option>
                    <option value="Number">Number</option>
                    <option value="Text">Text (Narrative)</option>
                    <option value="Date">Date</option>
                  </select>
                </div>
                <div class="col-md-3 mb-3">
                  <label for="addPrimaryCategory" class="form-label"
                    >Primary Category</label
                  >
                  <select
                    id="addPrimaryCategory"
                    name="IndicatorPrimaryCategory"
                    class="form-control"
                    v-model="newIndicator.IndicatorPrimaryCategory"
                    required
                  >
                    <option value="" disabled>Select Primary Category</option>
                    <option>Regional Results Framework</option>
                    <option>Country Results Framework</option>
                  </select>
                </div>
                <div class="col-md-3 mb-3">
                  <label for="addReportingPeriod" class="form-label"
                    >Reporting Period</label
                  >
                  <select
                    id="addReportingPeriod"
                    name="ReportingPeriod"
                    class="form-control"
                    v-model="newIndicator.ReportingPeriod"
                    required
                  >
                    <option value="" disabled>Select Reporting Period</option>
                    <option>Annual Report</option>
                    <option>Bi-Annual Report</option>
                    <option>Quarterly Report</option>
                  </select>
                </div>
                <div class="col-md-3 mb-3">
                  <label for="addSecondaryCategory" class="form-label"
                    >Secondary Category</label
                  >
                  <select
                    id="addSecondaryCategory"
                    name="IndicatorSecondaryCategory"
                    class="form-control"
                    v-model="newIndicator.IndicatorSecondaryCategory"
                    required
                  >
                    <option value="" disabled>Select Secondary Category</option>
                    <option>
                      Country Specific Project Development Objective Indicators
                    </option>
                    <option>
                      Country Specific Intermediate Results Indicators
                    </option>
                    <option>
                      Regional Project Development Objective Indicators
                    </option>
                    <option>Regional Intermediate Results Indicators</option>
                  </select>
                </div>
                <div class="col-md-6 mb-3">
                  <label for="addIndicator" class="form-label">Indicator</label>
                  <input
                    type="text"
                    id="addIndicator"
                    name="Indicator"
                    class="form-control"
                    v-model="newIndicator.Indicator"
                  />
                </div>
                <div class="col-md-6 mb-3">
                  <label for="addDefinition" class="form-label"
                    >Definition</label
                  >
                  <input
                    type="text"
                    id="addDefinition"
                    name="IndicatorDefinition"
                    class="form-control"
                    v-model="newIndicator.IndicatorDefinition"
                    required
                  />
                </div>
                <div class="col-md-6 mb-3">
                  <label for="addQuestion" class="form-label">Question</label>
                  <textarea
                    id="addQuestion"
                    name="IndicatorQuestion"
                    class="form-control"
                    v-model="newIndicator.IndicatorQuestion"
                    required
                  ></textarea>
                </div>
                <div class="col-md-6 mb-3">
                  <label for="addRemarksComments" class="form-label"
                    >Remarks/Comments</label
                  >
                  <textarea
                    id="addRemarksComments"
                    name="RemarksComments"
                    class="form-control"
                    v-model="newIndicator.RemarksComments"
                  ></textarea>
                </div>

                <input
                  type="hidden"
                  name="TableName"
                  value="project_indicators"
                />
              </div>
              <div class="modal-footer">
                <button type="submit" class="btn btn-primary">
                  Add Indicator
                </button>
                <button
                  type="button"
                  class="btn btn-secondary"
                  @click="closeAddModal"
                >
                  Cancel
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- Update Modal -->
    <div
      v-if="showUpdateForm"
      class="modal fade show d-block"
      id="updateIndicatorModal"
      tabindex="-1"
    >
      <div class="modal-dialog modal-fullscreen">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Update Indicator</h5>
            <button
              type="button"
              class="btn-close"
              @click="closeUpdateModal"
            ></button>
          </div>
          <div class="modal-body">
            <form ref="updateForm" @submit.prevent="submitUpdateForm">
              <div class="row">
                <div class="mb-3 col-md-4">
                  <label for="ResponseType" class="px-5 required form-label"
                    >Indicator Response Category</label
                  >
                  <select
                    id="ResponseType"
                    name="ResponseType"
                    class="form-select"
                    v-model="currentIndicator.ResponseType"
                    required
                  >
                    <option value="" disabled>Select an option</option>
                    <option value="Yes/No">Yes/No</option>
                    <option value="Percentage">Percentage</option>
                    <option value="Number">Number</option>
                    <option value="Text">Text (Narrative)</option>
                    <option value="Date">Date</option>
                  </select>
                </div>
                <div class="col-md-4 mb-3">
                  <label for="updatePrimaryCategory" class="form-label"
                    >Primary Category</label
                  >
                  <select
                    id="updatePrimaryCategory"
                    name="IndicatorPrimaryCategory"
                    class="form-control"
                    v-model="currentIndicator.IndicatorPrimaryCategory"
                    required
                  >
                    <option value="" disabled>Select Primary Category</option>
                    <option>Regional Results Framework</option>
                    <option>Country Results Framework</option>
                  </select>
                </div>
                <div class="col-md-4 mb-3">
                  <label for="updateSecondaryCategory" class="form-label"
                    >Secondary Category</label
                  >
                  <select
                    id="updateSecondaryCategory"
                    name="IndicatorSecondaryCategory"
                    class="form-control"
                    v-model="currentIndicator.IndicatorSecondaryCategory"
                    required
                  >
                    <option value="" disabled>Select Secondary Category</option>
                    <option>
                      Country Specific Project Development Objective Indicators
                    </option>
                    <option>
                      Country Specific Intermediate Results Indicators
                    </option>
                    <option>
                      Regional Project Development Objective Indicators
                    </option>
                    <option>Regional Intermediate Results Indicators</option>
                  </select>
                </div>
                <div class="col-md-6 mb-3">
                  <label for="updateIndicator" class="form-label"
                    >Indicator</label
                  >
                  <input
                    type="text"
                    id="updateIndicator"
                    name="Indicator"
                    class="form-control"
                    v-model="currentIndicator.Indicator"
                  />
                </div>
                <div class="col-md-6 mb-3">
                  <label for="updateDefinition" class="form-label"
                    >Definition</label
                  >
                  <input
                    type="text"
                    id="updateDefinition"
                    name="IndicatorDefinition"
                    class="form-control"
                    v-model="currentIndicator.IndicatorDefinition"
                    required
                  />
                </div>
                <div class="col-md-6 mb-3">
                  <label for="updateQuestion" class="form-label"
                    >Question</label
                  >
                  <textarea
                    id="updateQuestion"
                    name="IndicatorQuestion"
                    class="form-control"
                    v-model="currentIndicator.IndicatorQuestion"
                    required
                  ></textarea>
                </div>
                <div class="col-md-6 mb-3">
                  <label for="updateRemarksComments" class="form-label"
                    >Remarks/Comments</label
                  >
                  <textarea
                    id="updateRemarksComments"
                    name="RemarksComments"
                    class="form-control"
                    v-model="currentIndicator.RemarksComments"
                  ></textarea>
                </div>
                <div class="col-md-6 mb-3">
                  <label for="updateReportingPeriod" class="form-label"
                    >Reporting Period</label
                  >
                  <select
                    id="updateReportingPeriod"
                    name="ReportingPeriod"
                    class="form-control"
                    v-model="currentIndicator.ReportingPeriod"
                    required
                  >
                    <option value="" disabled>Select Reporting Period</option>
                    <option>Annual Report</option>
                    <option>Bi-Annual Report</option>
                    <option>Quarterly Report</option>
                  </select>
                </div>
                <input
                  type="hidden"
                  name="TableName"
                  value="project_indicators"
                />
                <input type="hidden" name="id" v-model="currentIndicator.id" />
              </div>
              <div class="modal-footer">
                <button type="submit" class="btn btn-primary">
                  Update Indicator
                </button>
                <button
                  type="button"
                  class="btn btn-secondary"
                  @click="closeUpdateModal"
                >
                  Cancel
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "MainComponent",
  data() {
    return {
      indicators: [],
      currentEntityId: "",
      Entity: "",
      newIndicator: {
        TableName: "project_indicators",
        IndicatorPrimaryCategory: "",
        IndicatorSecondaryCategory: "",
        Indicator: "",
        IndicatorDefinition: "",
        IndicatorQuestion: "",
        RemarksComments: "",
        ResponseType: "",
        ReportingPeriod: "",
      },
      currentIndicator: {},
      showAddForm: false,
      showUpdateForm: false,
      loading: true,
    };
  },
  methods: {
    fetchIndicators() {
      const entityID = this.$route.query.EntityID;

      if (entityID) {
        this.currentEntityId = entityID;

        this.$axios
          .post(`${window.SERVER_URL}FetchIndicators`, {
            EntityID: entityID,
          })
          .then((response) => {
            this.indicators = response.data.data;
            this.Entity = response.data.Entity;
            this.loading = false;

            // console.log(response.data.data);
          })
          .catch((error) => {
            console.error(
              "Error fetching data:",
              error.response?.data?.message || error.message
            );
            this.loading = false;
          });
      } else {
        console.error("EntityID not provided");
        this.loading = false;
      }
    },
    submitAddForm() {
      const form = this.$refs.addForm;
      const formData = new FormData(form);
      formData.append("EntityID", this.currentEntityId);

      this.$axios
        .post(`${window.SERVER_URL}MassInsert`, formData)
        .then(() => {
          Swal.fire(
            "Success",
            "Indicator has been added successfully",
            "success"
          );
          this.fetchIndicators();
          this.closeAddModal();
        })
        .catch((error) => {
          console.error(
            "Error adding indicator:",
            error.response?.data?.message || error.message
          );
        });
    },
    submitUpdateForm() {
      const form = this.$refs.updateForm;
      const formData = new FormData(form);

      this.$axios
        .post(`${window.SERVER_URL}MassUpdate`, formData)
        .then(() => {
          Swal.fire(
            "Success",
            "Indicator has been updated successfully",
            "success"
          );
          this.fetchIndicators();
          this.closeUpdateModal();
        })
        .catch((error) => {
          console.error(
            "Error updating indicator:",
            error.response?.data?.message || error.message
          );
        });
    },
    openAddModal() {
      this.showAddForm = true;
      this.$nextTick(() => {
        const modal = new bootstrap.Modal(
          document.getElementById("addIndicatorModal")
        );
        modal.show();
        // this.initializeSelect2(); // Initialize Select2 after showing the modal
      });
    },
    closeAddModal() {
      this.showAddForm = false;
      const modal = bootstrap.Modal.getInstance(
        document.getElementById("addIndicatorModal")
      );
      if (modal) modal.hide();
    },
    openUpdateModal(indicator) {
      // alert(indicator.id);
      this.$axios
        .post(`${window.SERVER_URL}FetchSpecificDataOneRecord`, {
          TableName: "project_indicators",
          ColumnName: "id",
          Value: indicator.id,
        })
        .then((response) => {
          if (response.data.status === "success") {
            this.currentIndicator = response.data.data;
            this.showUpdateForm = true;
            this.$nextTick(() => {
              const modal = new bootstrap.Modal(
                document.getElementById("updateIndicatorModal")
              );
              modal.show();
              this.initializeSelect2(); // Initialize Select2 after showing the modal
            });
          } else {
            Swal.fire("Error", response.data.message, "error");
          }
        })
        .catch((error) => {
          console.error(
            "Error fetching indicator data:",
            error.response?.data?.message || error.message
          );
        });
    },
    closeUpdateModal() {
      this.showUpdateForm = false;
      const modal = bootstrap.Modal.getInstance(
        document.getElementById("updateIndicatorModal")
      );
      if (modal) modal.hide();
    },
    confirmDelete(indicator) {
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
          this.$axios
            .delete(
              `${window.SERVER_URL}MassDelete/project_indicators/${indicator.id}`
            )
            .then(() => {
              Swal.fire(
                "Deleted!",
                "Your indicator has been deleted.",
                "success"
              );
              this.fetchIndicators();
            })
            .catch((error) => {
              console.error(
                "Error deleting indicator:",
                error.response?.data?.message || error.message
              );
            });
        }
      });
    },
    initializeSelect2() {
      this.$nextTick(() => {
        const selects = document.querySelectorAll("select");
        selects.forEach((select) => {
          $(select).select2({
            dropdownParent: $(select).closest(".modal-body"),
          });
        });
      });
    },
  },
  created() {
    this.fetchIndicators();
  },
};
</script>

<style scoped>
.form-label {
  font-weight: bold;
  color: #333;
}

.form-control {
  border-radius: 4px;
  border: 1px solid #ccc;
}

.btn-primary {
  background-color: #0078d7;
  border-color: #0078d7;
}

.btn-primary:hover {
  background-color: #005a9e;
  border-color: #005a9e;
}

.btn-secondary {
  background-color: #6c757d;
  border-color: #6c757d;
}

.btn-secondary:hover {
  background-color: #5a6268;
  border-color: #545b62;
}

.table {
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
}

.table th,
.table td {
  padding: 0.75rem;
  vertical-align: middle;
}

.table th {
  background-color: #f3f2f1;
  color: #333;
  font-weight: bold;
}

input[type="text"],
select {
  transition: all 0.3s ease-in-out;
}

input[type="text"]:focus,
select:focus {
  border-color: #0078d7;
  box-shadow: 0 0 8px rgba(0, 120, 215, 0.6);
}
</style>
