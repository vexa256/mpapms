<template>
  <div class="modal fade show d-block" id="updateIndicatorModal" tabindex="-1">
    <div class="modal-dialog modal-fullscreen">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Update Indicator</h5>
          <button
            type="button"
            class="btn-close"
            @click="$emit('close')"
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
                  required
                >
                  <option value="" disabled>Select an option</option>
                  <option
                    value="Yes/No"
                    :selected="indicator.ResponseType === 'Yes/No'"
                  >
                    Yes/No
                  </option>
                  <option
                    value="Percentage"
                    :selected="indicator.ResponseType === 'Percentage'"
                  >
                    Percentage
                  </option>
                  <option
                    value="Number"
                    :selected="indicator.ResponseType === 'Number'"
                  >
                    Number
                  </option>
                  <option
                    value="Text"
                    :selected="indicator.ResponseType === 'Text'"
                  >
                    Text (Narrative)
                  </option>
                  <option
                    value="Date"
                    :selected="indicator.ResponseType === 'Date'"
                  >
                    Date
                  </option>
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
                  required
                >
                  <option value="" disabled>Select Primary Category</option>
                  <option
                    :selected="
                      indicator.IndicatorPrimaryCategory ===
                      'Regional Results Framework'
                    "
                  >
                    Regional Results Framework
                  </option>
                  <option
                    :selected="
                      indicator.IndicatorPrimaryCategory ===
                      'Country Results Framework'
                    "
                  >
                    Country Results Framework
                  </option>
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
                  required
                >
                  <option value="" disabled>Select Secondary Category</option>
                  <option
                    :selected="
                      indicator.IndicatorSecondaryCategory ===
                      'Country Specific Project Development Objective Indicators'
                    "
                  >
                    Country Specific Project Development Objective Indicators
                  </option>
                  <option
                    :selected="
                      indicator.IndicatorSecondaryCategory ===
                      'Country Specific Intermediate Results Indicators'
                    "
                  >
                    Country Specific Intermediate Results Indicators
                  </option>
                  <option
                    :selected="
                      indicator.IndicatorSecondaryCategory ===
                      'Regional Project Development Objective Indicators'
                    "
                  >
                    Regional Project Development Objective Indicators
                  </option>
                  <option
                    :selected="
                      indicator.IndicatorSecondaryCategory ===
                      'Regional Intermediate Results Indicators'
                    "
                  >
                    Regional Intermediate Results Indicators
                  </option>
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
                  :value="indicator.Indicator"
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
                  :value="indicator.IndicatorDefinition"
                  required
                />
              </div>
              <div class="col-md-6 mb-3">
                <label for="updateQuestion" class="form-label">Question</label>
                <textarea
                  id="updateQuestion"
                  name="IndicatorQuestion"
                  class="form-control"
                  required
                  >{{ indicator.IndicatorQuestion }}</textarea
                >
              </div>
              <div class="col-md-6 mb-3">
                <label for="updateRemarksComments" class="form-label"
                  >Remarks/Comments</label
                >
                <textarea
                  id="updateRemarksComments"
                  name="RemarksComments"
                  class="form-control"
                  >{{ indicator.RemarksComments }}</textarea
                >
              </div>
              <div class="col-md-6 mb-3">
                <label for="updateReportingPeriod" class="form-label"
                  >Reporting Period</label
                >
                <select
                  id="updateReportingPeriod"
                  name="ReportingPeriod"
                  class="form-control"
                  required
                >
                  <option value="" disabled>Select Reporting Period</option>
                  <option
                    :selected="indicator.ReportingPeriod === 'Annual Report'"
                  >
                    Annual Report
                  </option>
                  <option
                    :selected="indicator.ReportingPeriod === 'Bi-Annual Report'"
                  >
                    Bi-Annual Report
                  </option>
                  <option
                    :selected="indicator.ReportingPeriod === 'Quarterly Report'"
                  >
                    Quarterly Report
                  </option>
                </select>
              </div>
              <input
                type="hidden"
                name="TableName"
                value="project_indicators"
              />
              <input type="hidden" name="id" :value="indicator.id" />
            </div>
            <div class="modal-footer">
              <button type="submit" class="btn btn-primary">
                Update Indicator
              </button>
              <button
                type="button"
                class="btn btn-secondary"
                @click="$emit('close')"
              >
                Cancel
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "UpdateForm",
  props: {
    entityId: String,
    indicator: Object,
  },
  methods: {
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
          this.$emit("updated");
          this.$emit("close");
        })
        .catch((error) => {
          console.error(
            "Error updating indicator:",
            error.response?.data?.message || error.message
          );
        });
    },
  },
  mounted() {
    this.initializeSelect2();
  },
  methods: {
    initializeSelect2() {
      this.$nextTick(() => {
        const selects = document.querySelectorAll(
          "#updateIndicatorModal select"
        );
        selects.forEach((select) => {
          $(select).select2({
            dropdownParent: $(select).closest(".modal-content"),
          });
        });
      });
    },
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

.modal-content {
  background-color: #fff;
  border-radius: 8px;
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
