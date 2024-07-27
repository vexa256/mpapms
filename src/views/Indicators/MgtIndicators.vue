<template>
  <div class="row">
    <FullScreenLoader v-if="loading" />
    <div class="card-body pt-3 fw-bolder text-white shadow-lg table-responsive">
      <div class="alert alert-primary shadow-lg">
        <span class="float-end svg-icon svg-icon-2hx svg-icon-primary me-3">
          <i class="fas fa-info fa-2x" aria-hidden="true"></i>
        </span>
        <div class="d-flex flex-column">
          <h4 class="mb-1 text-dark">
            Manage Project Indicators
            <span class="fw-bolder text-danger">
              for the entity {{ SelectedEntity }}
            </span>
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
          <i class="fas me-1 fa-plus" aria-hidden="true"></i> New Indicator
        </button>
      </div>
    </div>
    <div class="col-12 mt-3">
      <div class="card-body px-5 py-5 bg-light shadow-lg table-responsive">
        <table class="table table-rounded table-bordered border gy-3 gs-3">
          <thead>
            <tr class="fw-bold text-gray-800 border-bottom border-gray-200">
              <!-- <th class="">Primary Category</th> -->
              <th class="">Secondary Category</th>
              <!-- <th class="">Entity</th> -->
              <th class="">Indicator</th>
              <th class="">Definition</th>
              <th class="">Question</th>
              <th class="">Remarks/Comments</th>
              <th class="">Response Type</th>
              <th class="">Reporting Period</th>
              <th class="">Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="indicator in indicators" :key="indicator.id">
              <!-- <td class="">{{ indicator.IndicatorPrimaryCategory }}</td> -->
              <td class="">{{ indicator.IndicatorSecondaryCategory }}</td>
              <!-- <td class="bg-primary text-light fw-bolder">{{ indicator.EntityID }}</td> -->
              <td class="">{{ indicator.Indicator }}</td>
              <td class="">{{ indicator.IndicatorDefinition }}</td>
              <td class="">{{ indicator.IndicatorQuestion }}</td>
              <td class="">{{ indicator.RemarksComments }}</td>
              <td class="">{{ indicator.ResponseType }}</td>
              <td class="">{{ indicator.ReportingPeriod }}</td>
              <td class="">
                <div class="d-flex justify-content-end">
                  <button
                    class="btn shadow-lg btn-outline btn-outline-dashed btn-outline-dark btn-active-light-dark fw-bolder me-2"
                    @click="openUpdateModal(indicator)"
                  >
                    <i class="fas fa-pencil fs-3"></i>
                  </button>
                  <button
                    class="btn shadow-lg btn-outline btn-outline-dashed btn-outline-dark btn-active-light-dark fw-bolder me-2"
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
                <div class="col-md-6 mb-3">
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
                    <option value="Country Results Framework">
                      Country Results Framework
                    </option>
                    <option value="Regional Results Framework">
                      Regional Results Framework
                    </option>
                  </select>
                </div>
                <div class="col-md-6 mb-3">
                  <label for="ResponseType" class="form-label"
                    >Response Type</label
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
                <div class="col-md-6 mb-3">
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
                <div class="col-md-6 mb-3">
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
                    <option>Project Development Objective Indicators</option>
                    <option>Intermediate Results Indicators</option>
                    <option>
                      Regional Project Development Objective Indicators
                    </option>
                    <option>Regional Intermediate Results Indicators</option>
                  </select>
                </div>
                <div class="col-md-6 mb-3">
                  <label for="addIndicator" class="form-label">Indicator</label>
                  <textarea
                    type="text"
                    id="addIndicator"
                    name="Indicator"
                    class="form-control"
                    v-model="newIndicator.Indicator"
                    style="height: 150px"
                  ></textarea>
                </div>
                <div class="col-md-6 mb-3">
                  <label for="addDefinition" class="form-label"
                    >Definition</label
                  >
                  <textarea
                    type="text"
                    id="addDefinition"
                    name="IndicatorDefinition"
                    class="form-control"
                    v-model="newIndicator.IndicatorDefinition"
                    style="height: 150px"
                    required
                  ></textarea>
                </div>
                <div class="col-md-6 mb-3">
                  <label for="addQuestion" class="form-label">Question</label>
                  <textarea
                    type="text"
                    id="addQuestion"
                    name="IndicatorQuestion"
                    class="form-control"
                    v-model="newIndicator.IndicatorQuestion"
                    style="height: 150px"
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
                    style="height: 150px"
                  >
N/A</textarea
                  >
                </div>
              </div>
              <div class="modal-footer">
                <button
                  type="submit"
                  class="btn mx-1 float-end mb-2 btn-sm btn-danger"
                >
                  <i class="fas me-1 fa-plus" aria-hidden="true"></i> Save
                  Changes
                </button>
                <button
                  type="button"
                  class="btn mx-1 float-end mb-2 btn-sm btn-dark"
                  @click="closeAddModal"
                >
                  <i class="fas me-1 fa-close" aria-hidden="true"></i> Cancel
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
                <div class="col-md-6 mb-3">
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
                    <option>Project Development Objective Indicators</option>
                    <option>Intermediate Results Indicators</option>
                    <option>
                      Regional Project Development Objective Indicators
                    </option>
                    <option>Regional Intermediate Results Indicators</option>
                  </select>
                </div>
                <div class="col-md-6 mb-3">
                  <label for="updateDefinition" class="form-label"
                    >Definition</label
                  >
                  <textarea
                    type="text"
                    id="updateDefinition"
                    name="IndicatorDefinition"
                    class="form-control"
                    v-model="currentIndicator.IndicatorDefinition"
                    style="height: 150px"
                    required
                  ></textarea>
                </div>
                <div class="col-md-6 mb-3">
                  <label for="updateQuestion" class="form-label"
                    >Question</label
                  >
                  <textarea
                    type="text"
                    id="updateQuestion"
                    name="IndicatorQuestion"
                    class="form-control"
                    v-model="currentIndicator.IndicatorQuestion"
                    style="height: 150px"
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
                    style="height: 150px"
                  ></textarea>
                </div>
                <div class="col-md-6 mb-3">
                  <label for="ResponseType" class="form-label"
                    >Response Type</label
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
import pb from "../../pocketbase";
import Swal from "sweetalert2";
import FullScreenLoader, {
  isLoading,
} from "../../components/FullScreenLoader.vue";

export default {
  name: "MainComponent",
  data() {
    return {
      indicators: [],
      currentEntityId: "",
      Entity: "",
      SelectedEntity: "",
      newIndicator: {
        IndicatorPrimaryCategory: "",
        IndicatorSecondaryCategory: "",
        Indicator: "",
        IndicatorDefinition: "",
        IndicatorQuestion: "",
        RemarksComments: "",
        ResponseType: "",
        ReportingPeriod: "",
        status: "active", // Default value for status
      },
      currentIndicator: {},
      showAddForm: false,
      showUpdateForm: false,
      loading: true,
    };
  },
  methods: {
    async generateReportingID() {
      return Math.floor(Date.now() / 1000); // Unix timestamp in seconds
    },
    async fetchEntityById() {
      try {
        isLoading.value = true;
        const result = await pb
          .collection("mpa_entities")
          .getFirstListItem(`EntityID="${this.$route.query.entityid}"`);
        if (!result) throw new Error("Entity not found");
        console.log("Entity:", result);
        this.SelectedEntity = result.Entity;
      } catch (error) {
        console.error("Error fetching entity:", error.message);
        Swal.fire("Error", `Error fetching entity: ${error.message}`, "error");
      } finally {
        isLoading.value = false;
      }
    },
    async fetchIndicators() {
      const entityID = this.$route.query.entityid;
      await this.fetchEntityById();

      if (entityID) {
        this.currentEntityId = entityID;
        try {
          isLoading.value = true;
          const data = await pb
            .collection("mpa_project_indicators")
            .getFullList({
              filter: `EntityID="${entityID.toLowerCase()}"`,
            });
          this.indicators = data;
          this.Entity = data.length > 0 ? data[0].Entity : "";
          this.initDataTable(); // Initialize DataTable after data is fetched
        } catch (error) {
          console.error("Error fetching data:", error.message);
          Swal.fire("Error", `Error fetching data: ${error.message}`, "error");
        } finally {
          isLoading.value = false;
        }
      } else {
        console.error("EntityID not provided");
        this.loading = false;
      }
    },
    initDataTable() {
      this.$nextTick(() => {
        if ($.fn.DataTable.isDataTable("table")) {
          $("table").DataTable().clear().destroy();
        }
        $(document).ready(function () {
          $("table").DataTable({
            responsive: true,
            dom: "Bfrtip",
            pageLength: 5, // Set default number of records per page
            buttons: ["copy", "csv", "excel", "pdf", "print"],
          });
        });
      });
    },
    async submitAddForm() {
      try {
        isLoading.value = true;
        console.log("Submitting new indicator:", this.newIndicator);
        const response = await pb.collection("mpa_project_indicators").create({
          IID: await this.generateReportingID(),
          ...this.newIndicator,
          EntityID: this.currentEntityId.toLowerCase(),
        });
        if (!response) throw new Error("Error adding indicator");
        Swal.fire(
          "Success",
          "Indicator has been added successfully",
          "success"
        );
        await this.fetchIndicators();
        this.closeAddModal();
      } catch (error) {
        console.error("Error adding indicator:", error.message);
        Swal.fire("Error", `Error adding indicator: ${error.message}`, "error");
      } finally {
        isLoading.value = false;
      }
    },
    async submitUpdateForm() {
      try {
        isLoading.value = true;
        const response = await pb
          .collection("mpa_project_indicators")
          .update(this.currentIndicator.id, this.currentIndicator);
        if (!response) throw new Error("Error updating indicator");
        Swal.fire(
          "Success",
          "Indicator has been updated successfully",
          "success"
        );
        await this.fetchIndicators();
        this.closeUpdateModal();
      } catch (error) {
        console.error("Error updating indicator:", error.message);
        Swal.fire(
          "Error",
          `Error updating indicator: ${error.message}`,
          "error"
        );
      } finally {
        isLoading.value = false;
      }
    },
    openAddModal() {
      this.showAddForm = true;
      this.$nextTick(() => {
        const modal = new bootstrap.Modal(
          document.getElementById("addIndicatorModal")
        );
        modal.show();
      });
    },
    closeAddModal() {
      this.showAddForm = false;
      const modal = bootstrap.Modal.getInstance(
        document.getElementById("addIndicatorModal")
      );
      if (modal) modal.hide();
    },
    async openUpdateModal(indicator) {
      try {
        isLoading.value = true;
        const data = await pb
          .collection("mpa_project_indicators")
          .getOne(indicator.id);
        if (!data) throw new Error("Indicator not found");
        this.currentIndicator = data;
        this.showUpdateForm = true;
        this.$nextTick(() => {
          const modal = new bootstrap.Modal(
            document.getElementById("updateIndicatorModal")
          );
          modal.show();
        });
      } catch (error) {
        console.error("Error fetching indicator data:", error.message);
        Swal.fire(
          "Error",
          `Error fetching indicator data: ${error.message}`,
          "error"
        );
      } finally {
        isLoading.value = false;
      }
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
      }).then(async (result) => {
        if (result.isConfirmed) {
          try {
            isLoading.value = true;
            const response = await pb
              .collection("mpa_project_indicators")
              .delete(indicator.id);
            if (!response) throw new Error("Error deleting indicator");
            Swal.fire(
              "Deleted!",
              "Your indicator has been deleted.",
              "success"
            );
            await this.fetchIndicators();
          } catch (error) {
            console.error("Error deleting indicator:", error.message);
            Swal.fire(
              "Error",
              `Error deleting indicator: ${error.message}`,
              "error"
            );
          } finally {
            isLoading.value = false;
          }
        }
      });
    },
  },
  created() {
    this.fetchIndicators();
  },
};
</script>
