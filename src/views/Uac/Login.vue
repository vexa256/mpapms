<template>
  <div>
    <div class="d-flex flex-column flex-root">
      <!--begin::Authentication - Password reset -->
      <div class="d-flex flex-column flex-lg-row flex-column-fluid">
        <!--begin::Logo-->
        <a href="#" class="d-block d-lg-none mx-auto py-20">
          <img
            alt="Logo"
            src="/assets/logo.jpg"
            class="theme-light-show h-25px"
          />
          <img
            alt="Logo"
            src="/assets/logo.jpg"
            class="theme-dark-show h-25px"
          />
        </a>
        <!--end::Logo-->
        <!--begin::Aside-->
        <div
          class="d-flex flex-column flex-column-fluid flex-center w-lg-50 p-10"
        >
          <!--begin::Wrapper-->
          <div
            class="d-flex justify-content-between flex-column-fluid flex-column w-100 mw-450px"
          >
            <!--begin::Header-->
            <div class="d-flex flex-stack py-2">
              <!--begin::Back link-->
              <div class="me-2">
                <a
                  href="../../demo8/dist/authentication/layouts/fancy/sign-in.html"
                  class="btn btn-icon bg-light rounded-circle"
                >
                  <!--begin::Svg Icon | path: icons/duotune/arrows/arr002.svg-->
                  <span class="svg-icon svg-icon-2 svg-icon-gray-800">
                    <svg
                      width="24"
                      height="24"
                      viewBox="0 0 24 24"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M9.60001 11H21C21.6 11 22 11.4 22 12C22 12.6 21.6 13 21 13H9.60001V11Z"
                        fill="currentColor"
                      />
                      <path
                        opacity="0.3"
                        d="M9.6 20V4L2.3 11.3C1.9 11.7 1.9 12.3 2.3 12.7L9.6 20Z"
                        fill="currentColor"
                      />
                    </svg>
                  </span>
                  <!--end::Svg Icon-->
                </a>
              </div>
              <!--end::Back link-->
              <!--begin::Sign Up link-->
              <div class="m-0">
                <span
                  class="text-gray-400 fw-bold fs-5 me-2"
                  data-kt-translate="password-reset-head-desc"
                  >Already a member ?</span
                >
                <a
                  href="../../demo8/dist/authentication/layouts/fancy/sign-in.html"
                  class="link-primary fw-bold fs-5"
                  data-kt-translate="password-reset-head-link"
                  >Sign In</a
                >
              </div>
              <!--end::Sign Up link=-->
            </div>
            <!--end::Header-->
            <!--begin::Body-->
            <div class="py-20">
              <!--begin::Form-->
              <form
                class="form w-100"
                novalidate
                id="kt_password_reset_form"
                action="#"
              >
                <!--begin::Heading-->
                <div class="text-start mb-10">
                  <!--begin::Title-->
                  <h1
                    class="text-dark mb-3 fs-3x"
                    data-kt-translate="password-reset-title"
                  >
                    Forgot Password ?
                  </h1>
                  <!--end::Title-->
                  <!--begin::Text-->
                  <div
                    class="text-gray-400 fw-semibold fs-6"
                    data-kt-translate="password-reset-desc"
                  >
                    Enter your email to reset your password.
                  </div>
                  <!--end::Link-->
                </div>
                <!--begin::Heading-->
                <!--begin::Input group-->
                <div class="fv-row mb-10">
                  <input
                    class="form-control form-control-solid"
                    type="email"
                    placeholder="Email"
                    name="email"
                    autocomplete="off"
                    data-kt-translate="password-reset-input-email"
                  />
                </div>
                <!--end::Input group-->
                <!--begin::Actions-->
                <div class="d-flex flex-stack">
                  <!--begin::Link-->
                  <div class="m-0">
                    <button
                      id="kt_password_reset_submit"
                      class="btn btn-primary me-2"
                      data-kt-translate="password-reset-submit"
                    >
                      <!--begin::Indicator label-->
                      <span class="indicator-label">Submit</span>
                      <!--end::Indicator label-->
                      <!--begin::Indicator progress-->
                      <span class="indicator-progress"
                        >Please wait...
                        <span
                          class="spinner-border spinner-border-sm align-middle ms-2"
                        ></span
                      ></span>
                      <!--end::Indicator progress-->
                    </button>
                    <a
                      href=""
                      class="btn btn-lg btn-light-primary fw-bold"
                      data-kt-translate="password-reset-cancel"
                      >Cancel</a
                    >
                  </div>
                  <!--end::Link-->
                </div>
                <!--end::Actions-->
              </form>
              <!--end::Form-->
            </div>
            <!--end::Body-->
            <!--begin::Footer-->
            <div class="m-0">
              <!--begin::Toggle-->
              <button
                class="btn btn-flex btn-link rotate"
                data-kt-menu-trigger="click"
                data-kt-menu-placement="bottom-start"
                data-kt-menu-offset="0px, 0px"
              >
                <img
                  data-kt-element="current-lang-flag"
                  class="w-25px h-25px rounded-circle me-3"
                  src="https://img.freepik.com/free-vector/blue-world-map-design_1053-411.jpg?t=st=1722044670~exp=1722048270~hmac=bd4aa3ae04156e819dd8c8dda1b9cbe10ad5d88dbc52e66e58e50cb8e8cc1a8e&w=826"
                  alt=""
                />
                <span data-kt-element="current-lang-name" class="me-2"
                  >English</span
                >
                <!--begin::Svg Icon | path: icons/duotune/arrows/arr072.svg-->
                <span class="svg-icon svg-icon-3 svg-icon-muted rotate-180 m-0">
                  <svg
                    width="24"
                    height="24"
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      d="M11.4343 12.7344L7.25 8.55005C6.83579 8.13583 6.16421 8.13584 5.75 8.55005C5.33579 8.96426 5.33579 9.63583 5.75 10.05L11.2929 15.5929C11.6834 15.9835 12.3166 15.9835 12.7071 15.5929L18.25 10.05C18.6642 9.63584 18.6642 8.96426 18.25 8.55005C17.8358 8.13584 17.1642 8.13584 16.75 8.55005L12.5657 12.7344C12.2533 13.0468 11.7467 13.0468 11.4343 12.7344Z"
                      fill="currentColor"
                    />
                  </svg>
                </span>
                <!--end::Svg Icon-->
              </button>
              <!--end::Toggle-->
              <!--begin::Menu-->
              <div
                class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg-light-primary fw-semibold w-200px py-4"
                data-kt-menu="true"
                id="kt_auth_lang_menu"
              >
                <!--begin::Menu item-->
                <div class="menu-item px-3">
                  <a
                    href="#"
                    class="menu-link d-flex px-5"
                    data-kt-lang="English"
                  >
                    <span class="symbol symbol-20px me-4">
                      <img
                        data-kt-element="lang-flag"
                        class="rounded-1"
                        src="https://img.freepik.com/free-vector/blue-world-map-design_1053-411.jpg?t=st=1722044670~exp=1722048270~hmac=bd4aa3ae04156e819dd8c8dda1b9cbe10ad5d88dbc52e66e58e50cb8e8cc1a8e&w=826"
                        alt=""
                      />
                    </span>
                    <span data-kt-element="lang-name">English</span>
                  </a>
                </div>
                <!--end::Menu item-->
                <!--begin::Menu item-->
                <div class="menu-item px-3">
                  <a
                    href="#"
                    class="menu-link d-flex px-5"
                    data-kt-lang="Spanish"
                  >
                    <span class="symbol symbol-20px me-4">
                      <img
                        data-kt-element="lang-flag"
                        class="rounded-1"
                        src="https://img.freepik.com/free-vector/blue-world-map-design_1053-411.jpg?t=st=1722044670~exp=1722048270~hmac=bd4aa3ae04156e819dd8c8dda1b9cbe10ad5d88dbc52e66e58e50cb8e8cc1a8e&w=826"
                        alt=""
                      />
                    </span>
                    <span data-kt-element="lang-name">Spanish</span>
                  </a>
                </div>
                <!--end::Menu item-->
                <!--begin::Menu item-->
                <div class="menu-item px-3">
                  <a
                    href="#"
                    class="menu-link d-flex px-5"
                    data-kt-lang="German"
                  >
                    <span class="symbol symbol-20px me-4">
                      <img
                        data-kt-element="lang-flag"
                        class="rounded-1"
                        src="https://img.freepik.com/free-vector/blue-world-map-design_1053-411.jpg?t=st=1722044670~exp=1722048270~hmac=bd4aa3ae04156e819dd8c8dda1b9cbe10ad5d88dbc52e66e58e50cb8e8cc1a8e&w=826"
                        alt=""
                      />
                    </span>
                    <span data-kt-element="lang-name">German</span>
                  </a>
                </div>
                <!--end::Menu item-->
                <!--begin::Menu item-->
                <div class="menu-item px-3">
                  <a
                    href="#"
                    class="menu-link d-flex px-5"
                    data-kt-lang="Japanese"
                  >
                    <span class="symbol symbol-20px me-4">
                      <img
                        data-kt-element="lang-flag"
                        class="rounded-1"
                        src="https://img.freepik.com/free-vector/blue-world-map-design_1053-411.jpg?t=st=1722044670~exp=1722048270~hmac=bd4aa3ae04156e819dd8c8dda1b9cbe10ad5d88dbc52e66e58e50cb8e8cc1a8e&w=826"
                        alt=""
                      />
                    </span>
                    <span data-kt-element="lang-name">Japanese</span>
                  </a>
                </div>
                <!--end::Menu item-->
                <!--begin::Menu item-->
                <div class="menu-item px-3">
                  <a
                    href="#"
                    class="menu-link d-flex px-5"
                    data-kt-lang="French"
                  >
                    <span class="symbol symbol-20px me-4">
                      <img
                        data-kt-element="lang-flag"
                        class="rounded-1"
                        src="/assets/logo.jpg"
                        alt=""
                      />
                    </span>
                    <span data-kt-element="lang-name">French</span>
                  </a>
                </div>
                <!--end::Menu item-->
              </div>
              <!--end::Menu-->
            </div>
            <!--end::Footer-->
          </div>
          <!--end::Wrapper-->
        </div>
        <!--end::Aside-->
        <!--begin::Body-->

        <!--begin::Body-->
      </div>
      <!--end::Authentication - Password reset-->
    </div>
  </div>
</template>

<script></script>
