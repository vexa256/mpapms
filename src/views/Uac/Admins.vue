<template>
  <div class="row">
    <FullScreenLoader />
    <div class="card-body pt-3 fw-bolder text-white shadow-lg table-responsive">
      <div class="alert alert-primary shadow-lg">
        <!--begin::Icon-->
        <span class="float-end svg-icon svg-icon-2hx svg-icon-primary me-3">
          <i class="fas fa-info fa-2x" aria-hidden="true"></i>
        </span>
        <!--end::Icon-->

        <!--begin::Wrapper-->
        <div class="d-flex flex-column">
          <!--begin::Title-->
          <h4 class="mb-1 text-dark">Regional Admin Users Database</h4>
          <!--end::Title-->
          <!--begin::Content-->
          <span>Add and manage regional admin users</span>
          <!--end::Content-->
        </div>
        <!--end::Wrapper-->
      </div>
      <!--end::Alert-->
    </div>
    <div class="row mb-3">
      <div class="col-12 text-end">
        <button
          @click="showModal(true, {})"
          type="button"
          class="btn mx-1 float-end mb-2 btn-sm btn-danger"
        >
          <i class="fas me-1 fa-plus" aria-hidden="true"></i>New Admin User
        </button>
      </div>
    </div>

    <div class="col-12">
      <div class="card-body px-5 py-5 bg-light shadow-lg table-responsive">
        <table class="table table-rounded table-bordered border gy-3 gs-3">
          <thead>
            <tr class="fw-bold text-gray-800 border-bottom border-gray-200">
              <th class="bg-dark text-light fw-bolder">Name</th>
              <th class="bg-danger text-light fw-bolder">ROLE</th>
              <th class="bg-dark text-light fw-bolder">Email</th>
              <th class="bg-primary text-light fw-bolder">User Code</th>
              <th class="bg-primary text-light fw-bolder">Phone</th>
              <th class="bg-primary text-light fw-bolder">Nationality</th>
              <th class="bg-primary text-light fw-bolder">Phone Number</th>
              <th class="bg-primary text-light fw-bolder">Address</th>
              <th class="bg-primary text-light fw-bolder">
                Parent Organization
              </th>
              <th class="bg-primary text-light fw-bolder">Sex</th>
              <th class="bg-primary text-light fw-bolder">Job Title</th>
              <th class="bg-warning text-dark fw-bolder">Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="admin in admins" :key="admin.id">
              <td class="bg-dark text-light fw-bolder">{{ admin.name }}</td>
              <td class="bg-danger text-light fw-bolder">
                {{ admin.AccountRole }}
              </td>
              <td class="bg-dark text-light fw-bolder">{{ admin.email }}</td>
              <td class="bg-warning text-dark fw-bolder">
                {{ admin.UserCode }}
              </td>
              <td class="bg-warning text-dark fw-bolder">{{ admin.Phone }}</td>
              <td class="bg-warning text-dark fw-bolder">
                {{ admin.Nationality }}
              </td>
              <td class="bg-warning text-dark fw-bolder">
                {{ admin.PhoneNumber }}
              </td>
              <td class="bg-warning text-dark fw-bolder">
                {{ admin.Address }}
              </td>
              <td class="bg-warning text-dark fw-bolder">
                {{ admin.ParentOrganization }}
              </td>
              <td class="bg-warning text-dark fw-bolder">{{ admin.Sex }}</td>
              <td class="bg-warning text-dark fw-bolder">
                {{ admin.JobTitle }}
              </td>
              <td>
                <div class="d-flex justify-content-end">
                  <button
                    role="button"
                    class="btn btn-sm btn-warning text-dark fw-bolder me-2"
                    @click="showModal(true, admin)"
                  >
                    <i class="ki ki-pencil fs-3"></i>
                    <span class="indicator-label">Edit</span>
                  </button>
                  <button
                    role="button"
                    class="btn btn-sm btn-danger me-2"
                    @click="confirmDelete(admin)"
                  >
                    <i class="ki ki-trash fs-3"></i>
                    <span>Delete</span>
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Modal for Add/Edit -->
    <div v-if="isModalOpen" class="modal fade show d-block" id="LogicModal">
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">
              {{
                currentAdmin.id
                  ? "Edit Regional Admin User"
                  : "Add Regional Admin User"
              }}
            </h5>
            <button
              type="button"
              class="btn-close"
              @click="showModal(false, {})"
            ></button>
          </div>
          <div class="modal-body">
            <form @submit.prevent="submitForm">
              <div class="row">
                <div class="mb-3 col-md-4">
                  <label for="name" class="form-label">Name</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="currentAdmin.name"
                    required
                  />
                </div>
                <div class="mb-3 col-md-4">
                  <label for="email" class="form-label">Email</label>
                  <input
                    type="email"
                    class="form-control"
                    v-model="currentAdmin.email"
                    required
                  />
                </div>
                <div class="mb-3 d-none">
                  <label for="AccountRole" class="form-label"
                    >Account Role</label
                  >
                  <input
                    type="text"
                    class="form-control"
                    v-model="currentAdmin.AccountRole"
                    required
                  />
                </div>
                <div class="mb-3 col-md-4">
                  <label for="Phone" class="form-label">Phone</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="currentAdmin.Phone"
                  />
                </div>
                <div class="mb-3 col-md-4">
                  <label for="Nationality" class="form-label"
                    >Nationality</label
                  >
                  <input
                    type="text"
                    class="form-control"
                    v-model="currentAdmin.Nationality"
                  />
                </div>
                <div class="mb-3 col-md-4">
                  <label for="PhoneNumber" class="form-label"
                    >Phone Number</label
                  >
                  <input
                    type="text"
                    class="form-control"
                    v-model="currentAdmin.PhoneNumber"
                  />
                </div>
                <div class="mb-3 col-md-4">
                  <label for="Address" class="form-label">Address</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="currentAdmin.Address"
                  />
                </div>
                <div class="mb-3 col-md-4">
                  <label for="ParentOrganization" class="form-label"
                    >Parent Organization</label
                  >
                  <input
                    type="text"
                    class="form-control"
                    v-model="currentAdmin.ParentOrganization"
                  />
                </div>
                <div class="mb-3 col-md-4">
                  <label for="Sex" class="form-label">Sex</label>

                  <select
                    class="form-select"
                    data-control="select2"
                    data-placeholder="Select an option"
                    v-model="currentAdmin.Sex"
                  >
                    <option></option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                  </select>
                  <!-- <input type="text" class="form-control" /> -->
                </div>
                <div class="mb-3 col-md-4">
                  <label for="JobTitle" class="form-label">Job Title</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="currentAdmin.JobTitle"
                  />
                </div>
              </div>

              <button
                type="submit"
                class="btn mx-1 float-end mb-2 btn-sm btn-danger"
              >
                <i class="fas me-1 fa-plus" aria-hidden="true"></i>
                {{ currentAdmin.id ? "Update" : "Add" }} Admin User
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "AdminManagement",
  data() {
    return {
      admins: [],
      currentAdmin: {
        name: "",
        email: "",
        UserCode: "",
        Phone: "",
        Nationality: "",
        PhoneNumber: "",
        Address: "",
        ParentOrganization: "",
        Sex: "",
        JobTitle: "",
        AccountRole: "AdminAccount", // Initialize AccountRole
      },
      isModalOpen: false,
    };
  },
  methods: {
    LoadDataTables() {
      setTimeout(function () {
        $("table").DataTable({
          responsive: true,
          dom: "Bfrtip",
          buttons: ["copy", "csv", "excel", "pdf", "print"],
        });
      }, 1000);
    },
    fetchAdmins() {
      this.$axios
        .post(`${window.SERVER_URL}MassFetch`, {
          TableName: "users",
          ExcludeColumns: [],
        })
        .then((response) => {
          this.admins = response.data.data;
        })
        .catch((error) => {
          console.error("Error fetching admins:", error);
        });
    },
    showModal(open, admin) {
      this.isModalOpen = open;
      if (open && admin.id) {
        this.currentAdmin = { ...admin };
      } else {
        this.currentAdmin = {
          name: "",
          email: "",
          UserCode: "",
          Phone: "",
          Nationality: "",
          PhoneNumber: "",
          Address: "",
          ParentOrganization: "",
          Sex: "",
          JobTitle: "",
          AccountRole: "AdminAccount", // Ensure AccountRole is initialized
        };
      }
    },
    submitForm() {
      const url = this.currentAdmin.id
        ? `${window.SERVER_URL}MassUpdate`
        : `${window.SERVER_URL}MassInsert`;
      const payload = { ...this.currentAdmin, TableName: "users" };
      this.$axios
        .post(url, payload)
        .then(() => {
          Swal.fire(
            "Success",
            "Admin user has been processed successfully",
            "success"
          );
          this.fetchAdmins();
        })
        .catch((error) => {
          console.error("Error processing admin user:", error);
        })
        .finally(() => {
          this.showModal(false, {});
        });
    },
    confirmDelete(admin) {
      Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!",
      }).then((result) => {
        if (result.isConfirmed) {
          this.deleteAdmin(admin.id);
        }
      });
    },
    deleteAdmin(id) {
      this.$axios
        .delete(`${window.SERVER_URL}MassDelete/users/${id}`)
        .then(() => {
          Swal.fire("Deleted!", "The admin user has been deleted.", "success");
          this.fetchAdmins();
        })
        .catch((error) => {
          console.error("Error deleting admin user:", error);
        });
    },
  },
  created() {
    this.fetchAdmins();
    this.LoadDataTables();
  },
};
</script>

<style scoped>
.modal.fade.show {
  display: block;
  background: rgba(0, 0, 0, 0.5);
}
</style>
import Swal from 'sweetalert2';
