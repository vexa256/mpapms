<template>
  <div>
    <FullScreenLoader />
    <div
      class="card bgi-no-repeat bgi-size-contain mb-5 mb-lg-10 shadow-lg"
      style="
        background-color: #1b283f;
        height: 100px;
        overflow-y: hidden;
        background-position: right;
        background-image: url('/assets/media/svg/misc/taieri.svg');
      "
    >
      <!--begin::Body-->
      <div class="card-body d-flex flex-column justify-content-between">
        <!--begin::Title-->
        <h3 class="text-white fw-bold mb-5">
          <span class="lh-lg">
            Closed project {{ SelectedReport }} for {{ SelectedEntity }}
            <span class="fw-bolder text-warning">
              regional results framework</span
            ></span
          >
        </h3>
        <!--end::Title-->
      </div>
      <!--end::Body-->
    </div>
    <div class="col-12 mt-3">
      <div class="card-body px-5 py-5 bg-light shadow-lg table-responsive">
        <!-- DataTable: Critical Details -->
        <table id="datatable" ref="datatable" class="t table-bordered"></table>

        <!-- Full-screen Modal for Update -->
        <div class="modal bg-body fade" tabindex="-1" id="kt_modal_3">
          <div class="modal-dialog modal-fullscreen">
            <div class="modal-content shadow-none">
              <div class="modal-header">
                <h5 class="modal-title">
                  View reported the indicator :
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
                        v-model="updateForm.AnsweredQuestion"
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
                        v-model="updateForm.Comments"
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
                      <label class="form-label">Response</label>
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
import { ref, onMounted, nextTick } from "vue";
import { useRoute } from "vue-router";
import pb from "../../pocketbase";
import Swal from "sweetalert2";
import { isLoading } from "../../components/FullScreenLoader.vue";
import CustomInput from "/src/views/Report/ResponseInput.vue";

export default {
  components: { CustomInput },
  name: "ReportAnnual",
  setup() {
    const route = useRoute();
    const entityid = ref(route.query.entityid);
    const reportid = ref(route.query.reportingid);
    const indicators = ref([]);
    const selectedIndicator = ref(null);
    const SelectedEntity = ref(null);
    const SelectedReport = ref(null);
    const allIndicatorsData = ref([]);
    const updateForm = ref({});
    const responseInputType = ref("text");
    const responseInputProps = ref({});
    const responseInputOptions = ref([]);
    isLoading.value = true;

    const showError = (message) => Swal.fire("Error", message, "error");
    const showSuccess = (message) => Swal.fire("Success", message, "success");

    const fetchData = async (collection, filter = "") => {
      try {
        isLoading.value = true;
        return await pb.collection(collection).getFullList(200, { filter });
      } catch (error) {
        showError(`Error fetching ${collection}: ${error.message}`);
        return [];
      } finally {
        isLoading.value = false;
      }
    };

    const fetchSelectedEntity = async () => {
      const result = await fetchData(
        "mpa_entities",
        `EntityID="${entityid.value}"`
      );
      SelectedEntity.value = result.length ? result[0].Entity : null;
    };

    const fetchSelectedReport = async () => {
      const result = await fetchData(
        "mpa_reporting_timelines",
        `ReportingID="${route.query.reportingid}"`
      );
      SelectedReport.value = result.length ? result[0].ReportName : null;
    };

    const fetchIndicators = async () => {
      try {
        const filterString = `EntityID='${route.query.entityid}' && ReportingID='${route.query.reportingid}' && Year='${route.query.year}'`;
        const indicatorsData = await pb
          .collection("mpa_inactive_indicator_reports_details")
          .getFullList({ filter: filterString });

        const uniqueIndicators = indicatorsData.filter(
          (indicator, index, self) =>
            index === self.findIndex((i) => i.IID === indicator.IID)
        );

        if (!uniqueIndicators.length) {
          Swal.fire(
            "No Unreported Indicators",
            "You currently have no unreported indicators under this report, try another report.",
            "info"
          ).then(() => this.$router.back());
          isLoading.value = false;
          return;
        }

        indicators.value = uniqueIndicators;
        allIndicatorsData.value = uniqueIndicators;
        nextTick(() => initializeDataTable());
      } catch (error) {
        console.error("Error fetching indicators:", error);
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "Failed to fetch indicators data. Please try again later.",
        });
      } finally {
        isLoading.value = false;
      }
    };

    const initializeDataTable = () => {
      if ($.fn.DataTable.isDataTable("#datatable")) {
        $("#datatable").DataTable().destroy();
      }

      const dataSet = indicators.value.map((ind) => [
        ind.IndicatorSecondaryCategory,
        ind.Indicator,
        ind.Response,
        ind.AnsweredQuestion,
        ind.Comments,
        `<div class="d-flex justify-content-end">
          <button data-bs-toggle="modal" data-bs-target="#kt_modal_3" class="btn btn-sm btn-danger shadow-lg fw-bolder me-2 open-update" data-id="${ind.id}"><i class="fas fa-pencil fs-3"></i></button>
        </div>`,
      ]);

      const dataTable = $("#datatable").DataTable({
        data: dataSet,
        scrollX: true, // Enable horizontal scrolling
        columns: [
          { title: "Category" },
          { title: "Indicator" },
          { title: "Reported Response" },
          { title: "Question" },
          { title: "Comment" },
          { title: "Actions" },
        ],
        dom: "Bfrtip",
        buttons: ["csv", "excel", "pdf", "copy", "print"],
        responsive: true,
        paging: true,
        pageLength: 10,
      });

      $("#datatable").on("click", ".view-details", (e) =>
        viewDetails($(e.currentTarget).data("id"))
      );
      $("#datatable").on("click", ".open-update", (e) =>
        openUpdateModal($(e.currentTarget).data("id"))
      );
    };

    const viewDetails = (id) => {
      selectedIndicator.value = indicators.value.find((i) => i.id === id);
    };

    const openUpdateModal = (id) => {
      selectedIndicator.value = indicators.value.find((i) => i.id === id);
      Object.assign(updateForm.value, selectedIndicator.value, {
        EntityID: entityid.value,
        ReportingID: reportid.value,
        ReportedBy: "",
      });
      responseInputType.value =
        selectedIndicator.value.ResponseType === "Number"
          ? "number"
          : selectedIndicator.value.ResponseType === "Percentage"
          ? "number"
          : selectedIndicator.value.ResponseType === "Yes/No"
          ? "select"
          : "text";
      responseInputProps.value =
        responseInputType.value === "number"
          ? {
              type: "number",
              step: responseInputType.value === "Percentage" ? "0.01" : "1",
            }
          : { type: "text" };
      responseInputOptions.value =
        responseInputType.value === "select"
          ? [
              { value: "Yes", text: "Yes" },
              { value: "No", text: "No" },
            ]
          : [];
    };
    const submitUpdate = async () => {
      try {
        isLoading.value = true;
        const response =
          updateForm.value.ResponseType === "Percentage"
            ? `${updateForm.value.Response}%`
            : updateForm.value.Response;

        // Fetch the existing record using the constructed filter string
        const existingRecord = await pb
          .collection("mpa_indicator_reports")
          .getFirstListItem(
            `RID="${updateForm.value.RID}" && IID="${updateForm.value.IID}"`
          );

        if (existingRecord) {
          await pb
            .collection("mpa_indicator_reports")
            .update(existingRecord.id, {
              // RID: updateForm.value.RID,
              // IID: updateForm.value.IID,
              // EntityID: updateForm.value.EntityID,
              // ReportingID: updateForm.value.ReportingID,
              // ReportedBy: updateForm.value.ReportedBy,
              Response: response,
              Comments: updateForm.value.Comments,
              IndicatorScore: updateForm.value.IndicatorScore,
              AnsweredQuestion: updateForm.value.AnsweredQuestion,
              // ApprovalStatus: updateForm.value.ApprovalStatus,
              // ResponseType: updateForm.value.ResponseType,
            });
        }

        showSuccess("Indicator report updated successfully");
        fetchIndicators();
      } catch (error) {
        console.error("Error Details:", error); // Log the error details
        showError(`Error updating indicator report: ${error.message}`);
      } finally {
        isLoading.value = false;
        selectedIndicator.value = null;
        updateForm.value = {};
      }
    };

    onMounted(() => {
      entityid.value = route.query.entityid;
      reportid.value = route.query.reportingid;
      fetchSelectedEntity();
      fetchIndicators();
      fetchSelectedReport();
    });

    return {
      entityid,
      reportid,
      indicators,
      selectedIndicator,
      SelectedEntity,
      updateForm,
      responseInputType,
      responseInputProps,
      responseInputOptions,
      fetchSelectedEntity,
      fetchIndicators,
      initializeDataTable,
      viewDetails,
      SelectedReport,
      openUpdateModal,
      submitUpdate,
      isLoading,
    };
  },
};
</script>
