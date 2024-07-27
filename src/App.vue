<template>
  <div id="app">
    <div class="d-flex flex-column flex-root app-root" id="kt_app_root">
      <div class="app-page flex-column flex-column-fluid" id="kt_app_page">
        <Header />
        <div class="app-wrapper flex-column flex-row-fluid" id="kt_app_wrapper">
          <Sidebar />
          <Main />

          <Footer />
        </div>
      </div>
    </div>
    <div id="kt_scrolltop" class="scrolltop" data-kt-scrolltop="true">
      <i class="ki-duotone ki-arrow-up">
        <span class="path1"></span>
        <span class="path2"></span>
      </i>
    </div>
  </div>
</template>

<script>
import Header from "./components/Header.vue";
import Sidebar from "./components/Sidebar.vue";
import Footer from "./components/Footer.vue";
import Main from "./components/Main.vue";

export default {
  components: {
    Header,
    Sidebar,
    Footer,
    Main,
  },
};
</script>

<style>
/* Global styles */
</style>
