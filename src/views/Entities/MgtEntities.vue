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
          <h4 class="mb-1 text-dark">Entity/Country Database</h4>
          <!--end::Title-->
          <!--begin::Content-->
          <span
            >Add and remove countries/entities that report on indicators</span
          >
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
          <i class="fas me-1 fa-plus" aria-hidden="true"></i>New Entity
        </button>
      </div>
    </div>

    <div class="col-12">
      <div class="card-body px-5 py-5 bg-light shadow-lg table-responsive">
        <table class="table table-rounded table-bordered border gy-3 gs-3">
          <thead>
            <tr class="fw-bold text-gray-800 border-bottom border-gray-200">
              <th class="bg-dark text-light fw-bolder">Entity</th>
              <!-- <th>EntityID</th> -->
              <th class="bg-primary text-light fw-bolder">Entity Details</th>
              <!-- <th>Created At</th> -->
              <!-- <th>Updated At</th> -->
              <th class="bg-warning text-dark fw-bolder">Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="entity in entities" :key="entity.id">
              <td class="bg-dark text-light fw-bolder">{{ entity.Entity }}</td>
              <!-- <td>{{ entity.EntityID }}</td> -->
              <td class="bg-warning text-dark fw-bolder">
                {{ entity.EntityProjectDetails }}
              </td>
              <!-- <td>{{ entity.created_at }}</td> -->
              <!-- <td>{{ entity.updated_at }}</td> -->
              <td>
                <div class="d-flex justify-content-end">
                  <!-- Edit button with Google Material design and action indicator -->
                  <a
                    href="#"
                    class="btn btn-sm btn-warning text-dark fw-bolder me-2"
                    @click="showModal(true, entity)"
                  >
                    <i class="ki ki-pencil fs-3"></i>
                    <!-- Indicator Label -->
                    <span class="indicator-label">Edit</span>
                    <!-- Indicator Progress -->
                  </a>

                  <!-- Delete button with YouTube-like design -->
                  <a
                    href="#"
                    class="btn btn-sm btn-danger me-2"
                    @click="confirmDelete(entity)"
                  >
                    <i class="ki ki-trash fs-3"></i>
                    <span>Delete</span>
                  </a>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Modal for Add/Edit -->
    <div v-if="isModalOpen" class="modal fade show d-block" id="LogicModal">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">
              {{ currentEntity.id ? "Edit Entity" : "Add Entity" }}
            </h5>
            <button
              type="button"
              class="btn-close"
              @click="showModal(false, {})"
            ></button>
          </div>
          <div class="modal-body">
            <form @submit.prevent="submitForm">
              <div class="mb-3">
                <label for="Entity" class="form-label">Entity</label>
                <input
                  type="text"
                  class="form-control"
                  v-model="currentEntity.Entity"
                  required
                />
              </div>

              <!-- <input type="text" v-model="UUID" />
              <div class="mb-3">
                <label for="EntityID" class="form-label">Entity ID</label>
                <input
                  type="text"
                  class="form-control"
                  v-model="currentEntity.EntityID"
                  required
                />
              </div> -->
              <div class="mb-3">
                <label for="EntityProjectDetails" class="form-label"
                  >Entity Details</label
                >
                <textarea
                  class="form-control"
                  v-model="currentEntity.EntityProjectDetails"
                  required
                ></textarea>
              </div>
              <button type="submit" class="btn btn-primary">
                {{ currentEntity.id ? "Update" : "Add" }} Entity
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
  name: "EntityManagement",
  data() {
    return {
      entities: [],
      UUID: null,
      currentEntity: {},
      isModalOpen: false,
    };
  },
  methods: {
    MakeSelectSelect2() {
      document.addEventListener("DOMContentLoaded", (event) => {
        $("select").select2({
          dropdownParent: $("#LogicModal"),
        });
      });
    },
    LoadDataTables() {
      setTimeout(function () {
        $("table").DataTable({
          responsive: true,
          dom: "Bfrtip",
          buttons: ["copy", "csv", "excel", "pdf", "print"],
        });
      }, 1000);
    },
    fetchEntities() {
      this.$axios
        .post(`${window.SERVER_URL}MassFetch`, {
          TableName: "entities",
          ExcludeColumns: [],
        })
        .then((response) => {
          this.entities = response.data.data;
        })
        .catch((error) => {
          console.error("Error fetching entities:", error);
        });
    },
    showModal(open, entity) {
      this.isModalOpen = open;
      this.currentEntity = { ...entity };
    },
    submitForm() {
      const url = this.currentEntity.id
        ? `${window.SERVER_URL}MassUpdate`
        : `${window.SERVER_URL}MassInsert`;
      const payload = { ...this.currentEntity, TableName: "entities" };
      this.$axios
        .post(url, payload)
        .then(() => {
          Swal.fire(
            "Success",
            "Entity has been processed successfully",
            "success"
          );
          this.fetchEntities();
        })
        .catch((error) => {
          console.error("Error processing entity:", error);
        })
        .finally(() => {
          this.showModal(false, {});
        });
    },
    confirmDelete(entity) {
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
          this.deleteEntity(entity.id);
        }
      });
    },
    deleteEntity(id) {
      this.$axios
        .delete(`${window.SERVER_URL}MassDelete/entities/${id}`)
        .then(() => {
          Swal.fire("Deleted!", "Your entity has been deleted.", "success");
          this.fetchEntities();
        })
        .catch((error) => {
          console.error("Error deleting entity:", error);
        });
    },
  },
  created() {
    this.fetchEntities();
    this.MakeSelectSelect2();
  },

  mounted() {
    this.LoadDataTables();
    this.MakeSelectSelect2();
    this.UUID = window.generateHexadecimal;
  },
};
</script>

<style scoped>
.modal.fade.show {
  display: block;
  background: rgba(0, 0, 0, 0.5);
}
/* Basic Material Design Button Styles */
.btn.material-btn-edit,
.btn.material-btn-delete {
  border: none;
  border-radius: 50%;
  color: #fff;
  padding: 8px 8px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
  transition: box-shadow 0.3s, background-color 0.3s;
}

/* Specific styles for edit button */
.btn.material-btn-edit {
  background-color: #1976d2; /* Google Blue */
}

.btn.material-btn-edit:hover,
.btn.material-btn-edit:focus {
  background-color: #135ba1;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
}

/* Specific styles for delete button */
.btn.material-btn-delete {
  background-color: #d32f2f; /* YouTube Red */
}

.btn.material-btn-delete:hover,
.btn.material-btn-delete:focus {
  background-color: #a12323;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
}
</style>
