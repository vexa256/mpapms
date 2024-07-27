<template>
  <div id="MyMenus">
    <div
      v-for="category in menuCategories"
      :key="category.title"
      class="menu-item pt-5"
    >
      <div class="menu-content">
        <span class="menu-heading fw-bold text-uppercase fs-7">{{
          category.title
        }}</span>
      </div>
      <div
        v-for="item in category.items"
        :key="item.title"
        class="menu-item menu-accordion"
        data-kt-menu-trigger="click"
      >
        <span class="menu-link">
          <span class="menu-icon">
            <i class="ki-duotone ki-abstract-39 fs-1 text-danger">
              <span class="path1"></span>
              <span class="path2"></span>
            </i>
          </span>
          <span class="menu-title">{{ item.title }}</span>
          <span class="menu-arrow"></span>
        </span>
        <div class="menu-sub menu-sub-accordion {{ item.show }}">
          <div
            v-for="subItem in item.subItems"
            :key="subItem.title"
            class="menu-item"
          >
            <router-link class="menu-link" :to="subItem.link">
              <span class="menu-bullet">
                <span class="bullet bullet-dot"></span>
              </span>
              <span class="menu-title">{{ subItem.title }}</span>
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";

export default {
  name: "MenuLinks",
  setup() {
    const menuCategories = ref([
      {
        title: "Admin Options",
        items: [
          {
            title: "Data Settings",
            subItems: [
              {
                title: "Reporting Entities",
                link: "/MgtEntities",
              },
              {
                title: "Reporting Timelines",
                link: "/MgtTimelines",
              },

              {
                title: "Reporting Status",
                link: "/ReportStatus",
              },
              {
                title: "Tracked Indicators",
                link: "/SelectEntity",
              },
            ],
          },
          {
            title: "User Settings",
            subItems: [
              {
                title: "Regional Admins",
                link: "/Admins",
              },
              {
                title: "Country Admins",
                link: "/Countries",
              },
              {
                title: "Partner Accounts",
                link: "/Partners",
              },
            ],
          },
        ],
      },
      {
        title: "Project Reporting",
        show: "show",
        items: [
          {
            title: "Report Indicators",
            subItems: [
              {
                title: "Quarterly Indicators",
                link: "/QuaterlySelectEntity",
              },
              {
                title: "Bi-Annual Indicators",
                link: "/SelectEntityBiAnnual",
              },
              {
                title: "Annual Indicators",
                link: "/SelectEntityReport",
              },

              {
                title: "Regional Framework",
                link: "/RRFSelectEntity",
              },
            ],
          },
          {
            title: "My  Active Reports",
            show: "show",
            subItems: [
              {
                title: "Quarterly Reports",
                link: "/AQuarterlySelectEntity",
              },
              {
                title: "Bi-Annual Reports",
                link: "/ABiAnnualSelectEntity",
              },
              {
                title: "Annual Reports",
                link: "/AAnnualSelectEntity",
              },
              {
                title: "Regional Reports",
                link: "/ActiveRRFSelectEntity",
              },
            ],
          },
          {
            title: "My  Closed Reports",
            show: "show",
            subItems: [
              {
                title: "Quarterly Reports",
                link: "/IQuarterlyReportsReportEntity",
              },
              {
                title: "Bi-Annual Reports",
                link: "/IBiAnnualReportsReportEntity",
              },
              {
                title: "Annual Reports",
                link: "/IAnnualReportsReportEntity",
              },
              {
                title: "Regional Reports",
                link: "/IRRFReportsReportEntity",
              },
            ],
          },
        ],
      },
    ]);

    return {
      menuCategories,
    };
  },
};
</script>
