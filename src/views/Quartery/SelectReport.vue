<template>
  <div class="container px-5 py-5">
    <FullScreenLoader />
    <div class="card-body pt-3 fw-bolder text-white shadow-lg table-responsive">
      <div class="alert alert-info shadow-lg">
        <span class="float-end svg-icon svg-icon-2hx svg-icon-primary me-3">
          <i class="fas fa-info fa-2x" aria-hidden="true"></i>
        </span>
        <div class="d-flex flex-column">
          <h4 class="mb-1 text-dark">Select Quarterly Report</h4>
          <span
            >Select a quaterly report you want to file. All reporting actions
            will be attached to this report.</span
          >
        </div>
      </div>
    </div>
    <div class="card-body shadow-lg pt-3 bg-light table-responsive px-5 py-5">
      <div class="row">
        <div class="col-md-12">
          <form @submit.prevent="fetchIndicators">
            <div class="mb-3 col-md-12 py-5 my-5">
              <label class="px-5 my-5 required form-label">Report</label>
              <select
                v-model="selectedReport"
                class="form-select py-5 my-5 form-select-solid"
                required
              >
                <option></option>
                <option
                  v-for="report in reports"
                  :key="report.ReportingID"
                  :value="report.ReportingID"
                >
                  {{ report.ReportName }}
                </option>
              </select>
            </div>
            <div class="float-end my-3">
              <button class="btn btn-danger btn-sm shadow-lg" type="submit">
                Next
              </button>
            </div>
          </form>
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
  name: "ReportSelection",
  components: {
    FullScreenLoader,
  },
  data() {
    return {
      reports: [],
      selectedReport: null,
      entityId: null,
      entityid: "",
    };
  },
  methods: {
    async fetchEntityID() {
      this.entityid = this.$route.query.entityid;
      // Swal.fire(this.entityid);
    },
    async fetchReports() {
      isLoading.value = true;
      try {
        const data = await pb
          .collection("mpa_reporting_timelines")
          .getFullList({
            filter: `status="active" && Type="Quarterly Report"`,
          });
        this.reports = data;
      } catch (error) {
        console.error("Error fetching reports:", error.message);
        Swal.fire("Error", "Error fetching reports: " + error.message, "error");
      } finally {
        isLoading.value = false;
      }
    },
    fetchIndicators() {
      if (this.selectedReport) {
        console.log("Selected ReportingID:", this.selectedReport);
        this.$router.push({
          name: "ReportQuaterly",
          query: { reportingid: this.selectedReport, entityid: this.entityId },
        });
      } else {
        console.error("No report selected");
        Swal.fire("Warning", "No report selected", "warning");
      }
    },
  },
  created() {
    this.entityId = this.$route.query.entityid;
    this.fetchReports();
    this.fetchEntityID();
  },
};
</script>
