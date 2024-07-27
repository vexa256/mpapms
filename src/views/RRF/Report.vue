<template>
  <div>
    <FullScreenLoader />
    <div
      class="card-title pt-3 fw-bolder text-white shadow-lg table-responsive"
    >
      <div class="alert alert-dark shadow-lg">
        <span class="float-end svg-icon svg-icon-2hx svg-icon-primary me-3">
          <i class="fas fa-info fa-2x" aria-hidden="true"></i>
        </span>
        <div class="d-flex flex-column">
          <h6 class="mb-1 text-dark">
            Project Indicator
            {{ this.SelectedReport }}
            Reporting Interface for the entity {{ SelectedEntity }} (Regional
            Results Results Framework)
          </h6>
          <!-- <span>Your reporting under the report</span> -->
        </div>
      </div>
    </div>
    <div id="MyDataListener" class="col-12 mt-3">
      <div class="card-body px-5 py-5 bg-light shadow-lg table-responsive">
        <!-- First Table: Critical Details -->
        <table
          id="MyViewData"
          ref="table"
          class="table table-rounded table-bordered border gy-3 gs-3"
        >
          <thead>
            <tr class="fw-bold text-gray-800 border-bottom border-gray-200">
              <th class="fw-bolder">Category</th>
              <th class="fw-bolder">Category</th>
              <th class="fw-bolder">Indicator</th>
              <th class="fw-bolder">Definition</th>
              <th class="fw-bolder">Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="indicator in indicators" :key="indicator.id">
              <td class="fw-bolder">
                {{ indicator.IndicatorSecondaryCategory }}
              </td>

              <td class="fw-bolder">
                {{ indicator.ReportingPeriod }}
              </td>

              <td class="fw-bolder">
                {{ indicator.Indicator }}
              </td>
              <td class="fw-bolder">
                {{ indicator.IndicatorDefinition }}
              </td>
              <td>
                <div class="d-flex justify-content-end">
                  <button
                    class="btn btn-outline btn-outline-dashed btn-outline-secondary btn-active-light-secondary shadow-lg fw-bolder me-2"
                    @click="viewDetails(indicator)"
                    data-bs-toggle="modal"
                    data-bs-target="#kt_modal_2"
                  >
                    More
                  </button>
                  <button
                    class="btn btn-outline btn-outline-dashed btn-outline-secondary btn-active-light-secondary shadow-lg text-light fw-bolder me-2"
                    @click="openUpdateModal(indicator)"
                    data-bs-toggle="modal"
                    data-bs-target="#kt_modal_3"
                  >
                    <i class="fas fa-pencil fs-3"></i>
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>

        <!-- Full-screen Modal for Detailed View -->
        <div class="modal bg-body fade" tabindex="-1" id="kt_modal_2">
          <div class="modal-dialog modal-fullscreen">
            <div class="modal-content shadow-none">
              <div class="modal-header">
                <h5 class="modal-title">
                  Details for the Indicator
                  <span class="text-danger fw-bolder">{{
                    selectedIndicator?.Indicator
                  }}</span>
                </h5>
                <div
                  class="btn btn-icon btn-sm btn-active-light-primary ms-2"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                >
                  <i class="ki-duotone ki-cross fs-2x"
                    ><span class="path1"></span><span class="path2"></span
                  ></i>
                </div>
              </div>
              <div class="modal-body">
                <table
                  class="table table-rounded table-bordered border gy-3 gs-3"
                >
                  <thead>
                    <tr
                      class="fw-bold text-gray-800 border-bottom border-gray-200"
                    >
                      <th class="fw-bolder">Question</th>
                      <th class="fw-bolder">Remarks/Comments</th>
                      <th class="fw-bolder">Response Type</th>
                      <th class="fw-bolder">Reporting Period</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-if="selectedIndicator">
                      <td class="fw-bolder">
                        {{ selectedIndicator.IndicatorQuestion }}
                      </td>
                      <td class="fw-bolder">
                        {{ selectedIndicator.RemarksComments }}
                      </td>
                      <td class="fw-bolder">
                        {{ selectedIndicator.ResponseType }}
                      </td>
                      <td class="fw-bolder">
                        {{ selectedIndicator.ReportingPeriod }}
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="modal-footer">
                <button
                  type="button"
                  class="btn btn-danger shadow-lg"
                  data-bs-dismiss="modal"
                >
                  Close
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Full-screen Modal for Update -->
        <div class="modal bg-body fade" tabindex="-1" id="kt_modal_3">
          <div class="modal-dialog modal-fullscreen">
            <div class="modal-content shadow-none">
              <div class="modal-header">
                <h5 class="modal-title">
                  Report the indicator :
                  <span class="text-danger fw-bolder">{{
                    selectedIndicator?.Indicator
                  }}</span>
                </h5>
                <div
                  class="btn btn-icon btn-sm btn-active-light-primary ms-2"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                >
                  <i class="ki-duotone ki-cross fs-2x"
                    ><span class="path1"></span><span class="path2"></span
                  ></i>
                </div>
              </div>
              <div class="modal-body">
                <form @submit.prevent="submitUpdate">
                  <div class="row">
                    <div class="col-md-6 mb-3">
                      <label class="form-label">Indicator</label>
                      <textarea
                        style="height: 200px; color: red"
                        class="form-control"
                        v-model="updateForm.Indicator"
                      ></textarea>
                    </div>
                    <div class="col-md-6 mb-3">
                      <label class="form-label">Indicator Question</label>
                      <textarea
                        style="height: 200px"
                        class="form-control"
                        v-model="updateForm.IndicatorQuestion"
                      ></textarea>
                    </div>
                    <div class="col-md-6 mb-3">
                      <label class="form-label">Indicator Definition</label>
                      <textarea
                        style="color: red; height: 200px"
                        class="form-control"
                        v-model="updateForm.IndicatorDefinition"
                        readonly
                      ></textarea>
                    </div>
                    <div class="col-md-6 mb-3">
                      <label class="form-label">Your Remarks/Comments</label>
                      <textarea
                        style="height: 200px"
                        class="form-control"
                        v-model="updateForm.RemarksComments"
                      ></textarea>
                    </div>

                    <div class="col-md-6 mb-3 d-none">
                      <label class="form-label">Entity ID</label>
                      <input
                        style="color: red"
                        type="text"
                        class="form-control"
                        v-model="updateForm.EntityID"
                        readonly
                      />
                    </div>
                    <div class="col-md-6 mb-3 d-none">
                      <label class="form-label">Report ID</label>
                      <input
                        type="text"
                        class="form-control"
                        v-model="updateForm.ReportingID"
                        readonly
                      />
                    </div>
                    <div class="col-md-6 mb-3 d-none">
                      <label class="form-label">Reported By</label>
                      <input
                        type="text"
                        class="form-control"
                        v-model="updateForm.ReportedBy"
                      />
                    </div>
                    <div class="col-md-6 mb-3">
                      <label class="form-label">Expected Response Type</label>
                      <input
                        style="color: red"
                        type="text"
                        class="form-control"
                        v-model="updateForm.ResponseType"
                        readonly
                      />
                    </div>
                    <div class="col-md-6 mb-3">
                      <label class="form-label"
                        >Indicator Report Response</label
                      >
                      <CustomInput
                        v-model="updateForm.Response"
                        :type="responseInputType"
                        :options="responseInputOptions"
                      />
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button
                      type="button"
                      class="btn btn-light"
                      data-bs-dismiss="modal"
                    >
                      Close
                    </button>
                    <button
                      type="submit"
                      data-bs-dismiss="modal"
                      class="btn mx-1 float-end mb-2 btn- btn-danger"
                    >
                      Save changes
                    </button>
                  </div>
                </form>
              </div>
            </div>
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
import CustomInput from "/src/views/Report/ResponseInput.vue";

export default {
  name: "ReportAnnual",
  components: { CustomInput, FullScreenLoader },
  data() {
    return {
      reportid: null,
      entityid: null,
      indicators: [],
      selectedIndicator: null,
      SelectedEntity: null,
      SelectedReport: null,
      updateForm: {
        IndicatorQuestion: "",
        Indicator: "",
        IndicatorDefinition: "",
        RemarksComments: "",
        EntityID: "",
        ReportingID: "",
        ReportedBy: "",
        ResponseType: "",
        Response: "",
      },
      responseInputType: "text",
      responseInputProps: {},
      responseInputOptions: [],
    };
  },
  methods: {
    initDataTable() {
      this.$nextTick(() => {
        if ($.fn.DataTable.isDataTable("table")) {
          $("table").DataTable().destroy();
        }
        $("table").DataTable({
          responsive: true,
          dom: "Bfrtip",
          pageLength: 5,
          buttons: ["copy", "csv", "excel", "pdf", "print"],
        });
      });
    },
    async fetchSelectedEntity() {
      try {
        isLoading.value = true;
        const result = await pb
          .collection("mpa_entities")
          .getFirstListItem(`EntityID="${this.$route.query.entityid}"`);
        if (!result) throw new Error("Entity not found");
        this.SelectedEntity = result.Entity;
      } catch (error) {
        console.error("Error fetching entity:", error.message);
        Swal.fire("Error", `Error fetching entity: ${error.message}`, "error");
      } finally {
        isLoading.value = false;
      }
    },
    async fetchSelectedReport() {
      try {
        isLoading.value = true;
        const result = await pb
          .collection("mpa_rrf_active_reports")
          .getFirstListItem(`ReportingID="${this.$route.query.reportingid}"`);
        if (!result) throw new Error("Report not found");
        this.SelectedReport = result.ReportName;
      } catch (error) {
        console.error("Error fetching report:", error.message);
        Swal.fire("Error", `Error fetching report: ${error.message}`, "error");
      } finally {
        isLoading.value = false;
      }
    },
    async fetchIndicators() {
      isLoading.value = true;
      try {
        const indicatorsData = await pb
          .collection("mpa_rrf_indicators")
          .getFullList({
            filter: `ReportingID="${this.reportid}"`,
          });

        const indicatorReportsData = await pb
          .collection("mpa_indicator_reports")
          .getFullList();

        const filteredIndicators = indicatorsData.filter((indicator) => {
          return !indicatorReportsData.some(
            (report) =>
              report.EntityID === this.entityid &&
              report.IID === indicator.IID &&
              report.ReportingID === this.reportid
          );
        });

        if (filteredIndicators.length === 0) {
          Swal.fire(
            "No Unreported Indicators",
            "You currently have no unreported indicators under this report, try another report.",
            "info"
          ).then(() => {
            this.$router.back();
          });
        } else {
          this.indicators = filteredIndicators;
        }
      } catch (error) {
        console.error("Error fetching indicators:", error.message);
        Swal.fire(
          "Error",
          `Error fetching indicators: ${error.message}`,
          "error"
        );
      } finally {
        this.$nextTick(() => {
          this.initDataTable();
        });
        isLoading.value = false;
      }
    },
    viewDetails(indicator) {
      this.selectedIndicator = indicator;
    },
    openUpdateModal(indicator) {
      this.selectedIndicator = indicator;
      this.updateForm.IndicatorQuestion = indicator.IndicatorQuestion;
      this.updateForm.Indicator = indicator.Indicator;
      this.updateForm.IndicatorDefinition = indicator.IndicatorDefinition;
      this.updateForm.RemarksComments = indicator.RemarksComments;
      this.updateForm.EntityID = this.entityid;
      this.updateForm.ReportingID = this.reportid;
      this.updateForm.ReportedBy = ""; // Set this to the current user or fetch from context if applicable
      this.updateForm.ResponseType = indicator.ResponseType;
      this.updateForm.Response = "";

      if (indicator.ResponseType === "Number") {
        this.responseInputType = "number";
        this.responseInputProps = { type: "number" };
      } else if (indicator.ResponseType === "Percentage") {
        this.responseInputType = "number";
        this.responseInputProps = { type: "number", step: "0.01" };
      } else if (indicator.ResponseType === "Yes/No") {
        this.responseInputType = "select";
        this.responseInputOptions = [
          { value: "Yes", text: "Yes" },
          { value: "No", text: "No" },
        ];
      } else {
        this.responseInputType = "text";
        this.responseInputProps = { type: "text" };
      }
    },
    async submitUpdate() {
      try {
        isLoading.value = true;
        let response = this.updateForm.Response;
        if (this.updateForm.ResponseType === "Percentage") {
          response = `${response}%`;
        }
        const data = await pb.collection("mpa_indicator_reports").create({
          RID: this.reportid,
          IID: this.selectedIndicator.IID,
          EntityID: this.$route.query.entityid,
          ReportingID: this.updateForm.ReportingID,
          ReportedBy: this.updateForm.ReportedBy,
          Response: response,
          Comments: this.updateForm.RemarksComments,
          ResponseType: this.updateForm.ResponseType,
          AnsweredQuestion: this.updateForm.IndicatorQuestion,
        });
        if (!data) throw new Error("Error updating indicator report");

        Swal.fire(
          "Success",
          "Indicator report updated successfully",
          "success"
        );
      } catch (error) {
        console.error("Error updating indicator report:", error.message);
        Swal.fire(
          "Error",
          `Error updating indicator report: ${error.message}`,
          "error"
        );
      } finally {
        await this.fetchIndicators();
        this.$nextTick(() => {
          this.initDataTable();
        });
        isLoading.value = false;
        this.selectedIndicator = null;
        this.updateForm = {
          IndicatorQuestion: "",
          Indicator: "",
          IndicatorDefinition: "",
          RemarksComments: "",
          EntityID: "",
          ReportingID: "",
          ReportedBy: "",
          ResponseType: "",
          Response: "",
        };
        this.$bvModal.hide("kt_modal_3");
      }
    },
  },
  watch: {
    indicators() {
      this.$nextTick(() => {
        this.initDataTable();
      });
    },
  },
  created() {
    this.entityid = this.$route.query.entityid;
    this.reportid = this.$route.query.reportingid;
    this.fetchIndicators();
    this.fetchSelectedEntity();
    this.fetchSelectedReport();
  },
};
</script>
