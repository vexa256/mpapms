<template>
  <div>
    <FullScreenLoader v-if="isLoading" />

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
          <span class="lh-lg">Manage MPA Project Partner Admin Users</span>
        </h2>
        <!--end::Title-->
      </div>
      <!--end::Body-->
    </div>

    <div class="row mb-3">
      <div class="col-12 text-end">
        <button class="btn float-end btn-primary mb-3" @click="openCreateModal">
          Create
        </button>
      </div>
    </div>

    <div class="datatable-container mt-5">
      <div class="card">
        <div class="card-body table-responsive">
          <table
            id="usersTable"
            class="table table-striped table-bordered table-responsive"
          ></table>
        </div>
      </div>
    </div>

    <!-- Create/Edit User Modal -->
    <div
      class="modal fade"
      id="userModal"
      tabindex="-1"
      role="dialog"
      aria-labelledby="userModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="userModalLabel">
              {{
                isEditMode
                  ? "Edit MPA Project Partner  Admin User"
                  : "Create MPA Project Partner  Admin User"
              }}
            </h5>
            <button
              type="button"
              class="close"
              data-bs-dismiss="modal"
              aria-label="Close"
            >
              <span aria-hidden="true">X</span>
            </button>
          </div>
          <div class="modal-body">
            <form @submit.prevent="submitForm">
              <div class="row">
                <div class="form-group col-md-6">
                  <label for="name">Name</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="formData.name"
                    required
                  />
                </div>
                <div class="form-group col-md-6">
                  <label for="EntityID">Entity</label>
                  <select
                    class="form-control"
                    v-model="formData.EntityID"
                    required
                  >
                    <option
                      v-for="entity in entities"
                      :key="entity.EntityID"
                      :value="entity.EntityID"
                    >
                      {{ entity.Entity }}
                    </option>
                  </select>
                </div>
                <!-- <div class="form-group col-md-6">
                    <label for="UserCode">User Code</label>
                    <input
                      type="text"
                      class="form-control"
                      v-model="formData.UserCode"
                      required
                    />
                  </div> -->
                <div class="form-group col-md-6">
                  <label for="Phone">Phone</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="formData.Phone"
                  />
                </div>

                <div class="form-group col-md-6">
                  <label for="Nationality">Nationality</label>
                  <select
                    class="form-control"
                    v-model="formData.Nationality"
                    required
                  >
                    <option
                      v-for="entity in entities"
                      :key="entity.EntityID"
                      :value="entity.Entity"
                    >
                      {{ entity.Entity }}
                    </option>
                  </select>
                </div>

                <div class="form-group col-md-6">
                  <label for="PhoneNumber">Phone Number</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="formData.PhoneNumber"
                  />
                </div>
                <div class="form-group col-md-6">
                  <label for="Address">Address</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="formData.Address"
                  />
                </div>
                <div class="form-group col-md-6">
                  <label for="ParentOrganization">Parent Organization</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="formData.ParentOrganization"
                  />
                </div>
                <div class="form-group col-md-6">
                  <label for="Sex">Sex</label>
                  <select class="form-control" v-model="formData.Sex">
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                  </select>
                </div>
                <div class="form-group col-md-6">
                  <label for="JobTitle">Job Title</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="formData.JobTitle"
                  />
                </div>
                <!-- <div class="form-group col-md-6">
                    <label for="AccountRole">Account Role</label>
                    <input
                      type="text"
                      class="form-control"
                      v-model="formData.AccountRole"
                    />
                  </div> -->
                <!-- <div class="form-group col-md-6">
                    <label for="UserID">User ID</label>
                    <input
                      type="text"
                      class="form-control"
                      v-model="formData.UserID"
                      required
                    />
                  </div> -->
                <div class="form-group col-md-6">
                  <label for="email">Email</label>
                  <input
                    type="email"
                    class="form-control"
                    v-model="formData.email"
                  />
                </div>
                <!-- <div class="form-group col-md-6">
                    <label for="password">Password</label>
                    <input
                      type="password"
                      class="form-control"
                      v-model="formData.password"
                    />
                  </div> -->
              </div>
              <div class="modal-footer">
                <button type="submit" class="btn btn-primary">
                  {{ isEditMode ? "Update" : "Create" }}
                </button>

                <button
                  type="button"
                  class="btn btn-light"
                  data-bs-dismiss="modal"
                >
                  Close
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, onUnmounted, nextTick } from "vue";
import Swal from "sweetalert2";
import FullScreenLoader, {
  isLoading,
} from "../../components/FullScreenLoader.vue";
import sendEmail from "/src/welcome_email.js";
import pb from "../../pocketbase";

export default {
  components: {
    FullScreenLoader,
  },
  setup() {
    const users = ref([]);
    const entities = ref([]);
    const isEditMode = ref(false);
    const dataTable = ref(null);
    const formData = ref({
      name: "",
      EntityID: "",
      UserCode: "",
      Phone: "",
      Nationality: "",
      PhoneNumber: "",
      Address: "",
      ParentOrganization: "",
      Sex: "Male",
      JobTitle: "",
      AccountRole: "partner",
      UserID: "",
      email: "",
      password: "",
    });

    onMounted(async () => {
      isLoading.value = true;
      await fetchEntities();
      await fetchUsers();
      setupRealtime();
      nextTick(() => {
        initDataTable();
      });
    });

    onUnmounted(() => {
      unsubscribeRealtime();
      if (dataTable.value) {
        dataTable.value.destroy(true);
      }
    });

    const fetchUsers = async () => {
      try {
        isLoading.value = true;
        const records = await pb
          .collection("mpa_users")
          .getFullList({ sort: "-created" });
        users.value = records.map((record) => ({
          id: record.id,
          name: record.name,
          EntityID: record.EntityID,
          UserCode: record.UserCode,
          Phone: record.Phone,
          Nationality: record.Nationality,
          PhoneNumber: record.PhoneNumber,
          Address: record.Address,
          ParentOrganization: record.ParentOrganization,
          Sex: record.Sex,
          JobTitle: record.JobTitle,
          AccountRole: "partner",
          UserID: record.UserID,
          email: record.email,
          password: record.password,
        }));
        updateDataTable();
      } catch (error) {
        console.error("Fetch users error:", error);
        Swal.fire(
          "Error",
          `Failed to fetch users data: ${error.message}`,
          "error"
        );
      } finally {
        isLoading.value = false;
      }
    };

    const fetchEntities = async () => {
      try {
        isLoading.value = true;
        const records = await pb
          .collection("mpa_entities")
          .getFullList({ sort: "Entity" });
        entities.value = records.map((record) => ({
          Entity: record.Entity,
          EntityID: record.EntityID,
        }));
      } catch (error) {
        console.error("Fetch entities error:", error);
        Swal.fire(
          "Error",
          `Failed to fetch entities data: ${error.message}`,
          "error"
        );
      } finally {
        isLoading.value = false;
      }
    };

    const setupRealtime = () => {
      pb.autoCancellation(false); // Disable auto cancellation globally
      pb.collection("mpa_users").subscribe("*", handleRealtimeEvent);
    };

    const unsubscribeRealtime = () => {
      pb.collection("mpa_users").unsubscribe("*");
    };

    const handleRealtimeEvent = (e) => {
      switch (e.action) {
        case "create":
          users.value.push(e.record);
          break;
        case "update":
          const index = users.value.findIndex(
            (user) => user.id === e.record.id
          );
          if (index !== -1) {
            users.value[index] = e.record;
          }
          break;
        case "delete":
          users.value = users.value.filter((user) => user.id !== e.record.id);
          break;
      }
      updateDataTable();
    };

    const initDataTable = () => {
      dataTable.value = $("#usersTable").DataTable({
        data: users.value,
        columns: [
          { title: "Name", data: "name" },
          { title: "User Code", data: "UserCode" },
          { title: "Phone", data: "Phone" },
          { title: "Nationality", data: "Nationality" },
          { title: "Phone Number", data: "PhoneNumber" },
          { title: "Address", data: "Address" },
          { title: "Parent Organization", data: "ParentOrganization" },
          { title: "Sex", data: "Sex" },
          { title: "Job Title", data: "JobTitle" },
          { title: "Account Role", data: "AccountRole" },
          { title: "Email", data: "email" },
          {
            title: "Actions",
            data: null,
            defaultContent:
              '<button class="btn btn-sm btn-primary edit-btn"><i class="fas fa-edit"></i></button><button class="btn btn-sm btn-danger delete-btn"><i class="fas fa-trash"></i> </button>',
          },
        ],
        dom: "Bfrtip",
        buttons: ["copy", "csv", "excel", "pdf", "print"],
        destroy: true, // Allow reinitialization
        responsive: true,
      });

      $("#usersTable").on("click", ".edit-btn", function () {
        const data = dataTable.value.row($(this).parents("tr")).data();
        openEditModal(data);
      });

      $("#usersTable").on("click", ".delete-btn", function () {
        const data = dataTable.value.row($(this).parents("tr")).data();
        deleteUser(data.id);
      });
    };

    const updateDataTable = () => {
      if (dataTable.value) {
        dataTable.value.clear().rows.add(users.value).draw();
      }
    };

    const openEditModal = (user) => {
      isEditMode.value = true;
      formData.value = { ...user };
      $("#userModal").modal("show");
    };

    const openCreateModal = () => {
      isEditMode.value = false;
      formData.value = {
        name: "",
        EntityID: "",
        UserCode: generateUniqueCode(),
        Phone: "",
        Nationality: "",
        PhoneNumber: "",
        Address: "",
        ParentOrganization: "",
        Sex: "Male",
        JobTitle: "",
        AccountRole: "admin",
        UserID: generateUniqueID(),
        email: "",
        password: generateUniquePassword(),
      };
      $("#userModal").modal("show");
    };

    const submitForm = async () => {
      try {
        isLoading.value = true;
        isEditMode.value ? await updateUser() : await createUser();
      } catch (error) {
        console.error("Submit form error:", error);
        Swal.fire("Error", `Failed to submit form: ${error.message}`, "error");
      } finally {
        isLoading.value = false;
      }
    };

    const createUser = async () => {
      try {
        isLoading.value = true;
        const user = await pb.collection("mpa_users").create(formData.value);
        Swal.fire("Success", "User created successfully.", "success");
        $("#userModal").modal("hide");

        // Send a welcome email to the new user
        await sendEmail(
          formData.value.email,
          formData.value.name,
          formData.value.UserCode,
          formData.value.password
        );
      } catch (error) {
        console.error("Create user error:", error);
        Swal.fire({
          title: "Error",
          text: `Failed to create user: ${error.message}. Please check the console for more details.`,
          icon: "error",
          confirmButtonText: "OK",
        });
      } finally {
        isLoading.value = false;
      }
    };

    const updateUser = async () => {
      try {
        isLoading.value = true;
        await pb
          .collection("mpa_users")
          .update(formData.value.id, formData.value);
        Swal.fire("Success", "User updated successfully.", "success");
        $("#userModal").modal("hide");
      } catch (error) {
        console.error("Update user error:", error);
        Swal.fire("Error", `Failed to update user: ${error.message}`, "error");
      } finally {
        isLoading.value = false;
      }
    };

    const deleteUser = async (userID) => {
      try {
        const result = await Swal.fire({
          title: "Are you sure?",
          text: "You won't be able to revert this!",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "Yes, delete it!",
        });
        if (result.isConfirmed) {
          isLoading.value = true;
          await pb.collection("mpa_users").delete(userID);
          Swal.fire("Deleted!", "User has been deleted.", "success");
        }
      } catch (error) {
        console.error("Delete user error:", error);
        Swal.fire("Error", `Failed to delete user: ${error.message}`, "error");
      } finally {
        isLoading.value = false;
      }
    };

    const generateUniqueNumber = () => {
      const randomPart = Math.floor(Math.random() * 10000); // 4 digits
      const timestampPart = Date.now() % 100000; // Last 5 digits of the timestamp
      const combined = (randomPart + timestampPart).toString().slice(0, 6);

      // Ensure the combined result is 6 digits long
      return combined.padStart(6, "0");
    };

    const generateUniqueID = () => {
      return generateUniqueNumber();
    };

    const generateUniqueCode = () => {
      return generateUniqueNumber();
    };

    const generateUniquePassword = () => {
      return generateUniqueNumber();
    };

    // Usage examples
    console.log(generateUniqueID());
    console.log(generateUniqueCode());
    console.log(generateUniquePassword());

    return {
      users,
      entities,
      isEditMode,
      formData,
      openCreateModal,
      submitForm,
    };
  },
};
</script>
