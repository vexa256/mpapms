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
        <div class="menu-sub menu-sub-accordion">
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
                link: "/country-admins",
              },
              {
                title: "Partner Accounts",
                link: "/partner-accounts",
              },
            ],
          },
        ],
      },
      {
        title: "Project Reporting",
        items: [
          {
            title: "Report Indicators",
            subItems: [
              {
                title: "Quarterly Indicators",
                link: "/quarterly-indicators",
              },
              {
                title: "Bi-Annual Indicators",
                link: "/bi-annual-indicators",
              },
              {
                title: "Annual Indicators",
                link: "/annual-indicators",
              },
            ],
          },
          {
            title: "Review Reports",
            subItems: [
              {
                title: "Pending Review",
                link: "/pending-review",
              },
              {
                title: "Approved Reports",
                link: "/approved-reports",
              },
              {
                title: "Returned Reports",
                link: "/returned-reports",
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
