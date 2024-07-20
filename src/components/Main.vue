<template>
  <div>
    <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
      <!--begin::Content wrapper-->
      <div class="d-flex flex-column flex-column-fluid">
        <!--begin::Content-->
        <div id="kt_app_content" class="app-content flex-column-fluid">
          <!--begin::Content container-->
          <div
            id="kt_app_content_container"
            class="app-container container-fluid"
          >
            <!--begin::Row-->
            <div class="row g-5 gx-xl-12">
              <!--begin::Col-->
              <div class="col-md-12 col-lg-12 col-xl-12 col-xxl-12">
                <router-view />
              </div>

              <!--end::Col-->
            </div>

            <!--end::Row-->
          </div>
          <!--end::Content container-->
        </div>
        <!--end::Content-->
      </div>
      <!--end::Content wrapper-->
    </div>
  </div>
</template>
<script>
export default {
  name: "Main",
};
</script>

<style scoped>
/* Add your styles here */
</style>
