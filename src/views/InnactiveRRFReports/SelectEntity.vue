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
        <h2 class="text-white fw-bold mb-5">
          <span class="lh-lg">Closed Project Indicator RRF Reports</span>
        </h2>
        <!--end::Title-->
      </div>
      <!--end::Body-->
    </div>
    <div class="col-xxl-12 col-md-12 mb-5 mb-xl-0 shadow-lg">
      <!--begin::List widget 8-->
      <div class="card card-flush h-lg-100">
        <!--begin::Header-->
        <div class="card-header pt-7 mb-5">
          <!--begin::Title-->
          <h3 class="card-title align-items-start flex-column">
            <span class="card-label fw-bold text-gray-800"
              >Select the entity whose RRF reports are required
            </span>
            <span class="text-gray-500 mt-1 fw-semibold fs-6"
              >Only entities with reported indicators are shown</span
            >
          </h3>
          <!--end::Title-->

          <!--begin::Toolbar-->
          <div class="card-toolbar"></div>
          <!--end::Toolbar-->
        </div>
        <!--end::Header-->

        <!--begin::Body-->
        <div class="card-body pt-0">
          <!--begin::Items-->
          <div class="m-0">
            <div v-for="entity in entities" :key="entity.EntityID" class="mb-4">
              <!--begin::Item-->
              <div class="d-flex flex-stack">
                <!--begin::Flag-->
                <img
                  src="/assets/map.png"
                  class="me-4 w-s25px shadow-lg"
                  style="border-radius: 43px; height: 150px"
                  alt=""
                />
                <!--end::Flag-->
                <!--begin::Section-->
                <div class="d-flex flex-stack flex-row-fluid d-grid gap-2">
                  <!--begin::Content-->
                  <div class="me-5">
                    <!--begin::Title-->
                    <a
                      href="#"
                      class="text-gray-800 fw-bold text-hover-primary fs-3"
                      >{{ entity.Entity }}</a
                    >
                    <!--end::Title-->
                    <!--begin::Desc-->
                    <span
                      class="text-gray-500 fw-semibold fs-7 d-block text-start ps-0"
                      >{{ entity.EntityProjectDetails }}</span
                    >
                    <!--end::Desc-->
                  </div>
                  <!--end::Content-->
                  <!--begin::Info-->
                  <div class="d-flex align-items-center">
                    <!--begin::Label-->
                    <div class="m-0">
                      <!--begin::Label-->
                      <span class="badge badge-light-success fs-base">
                        <button
                          @click="selectEntity(entity.EntityID)"
                          class="btn btn-sm btn-light"
                        >
                          Select Entity
                        </button>
                      </span>
                      <!--end::Label-->
                    </div>
                    <!--end::Label-->
                  </div>
                  <!--end::Info-->
                </div>
                <!--end::Section-->
              </div>

              <div class="separator separator-dashed my-3"></div>
              <!--end::Item-->
            </div>

            <!--begin::Separator-->

            <!--end::Separator-->
          </div>
          <!--end::Items-->
        </div>
        <!--end::Body-->
      </div>
      <!--end::LIst widget 8-->
    </div>
  </div>
</template>

<script>
import pb from "/src/pocketbase.js";
import Swal from "sweetalert2";
import FullScreenLoader, {
  isLoading,
} from "/src/components/FullScreenLoader.vue";

export default {
  name: "EntitySelection",
  components: {
    FullScreenLoader,
  },
  data() {
    return {
      entities: [],
      selectedEntity: null,
    };
  },
  methods: {
    async fetchEntities() {
      isLoading.value = true;
      try {
        const data = await pb
          .collection("mpa_inactive_indicator_reports_details")
          .getFullList({
            filter: `IndicatorPrimaryCategory = "Regional Results Framework"`,
          });

        // Extract unique entities
        const uniqueEntities = data.reduce((acc, current) => {
          if (!acc.find((entity) => entity.Entity === current.Entity)) {
            acc.push(current);
          }
          return acc;
        }, []);

        this.entities = uniqueEntities;

        console.log(this.entities);

        if (this.entities.length === 0) {
          Swal.fire({
            title: "No entities found",
            text: "No entities were found. Entities need to report indicators to appear here.",
            icon: "warning",
            confirmButtonText: "OK",
          });
        }
      } catch (error) {
        console.error("Error fetching entities:", error.message);
        Swal.fire(
          "Error",
          "Error fetching entities: " + error.message,
          "error"
        );
      } finally {
        isLoading.value = false;
      }
    },
    selectEntity(entityId) {
      this.$router.push({
        name: "IRRFReportsYear",
        query: { entityid: entityId },
      });
    },
  },
  created() {
    this.fetchEntities();
  },
};
</script>
