<template>
  <div class="row">
    <FullScreenLoader />
    <div class="card-body pt-3 fw-bolder text-white shadow-lg table-responsive">
      <div class="alert alert-primary shadow-lg">
        <span class="float-end svg-icon svg-icon-2hx svg-icon-primary me-3">
          <i class="fas fa-info fa-2x" aria-hidden="true"></i>
        </span>
        <div class="d-flex flex-column">
          <h4 class="mb-1 text-dark">Entity/Country Database</h4>
          <span
            >Add and remove countries/entities that report on indicators</span
          >
        </div>
      </div>
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
              <th class="fw-bolder">Entity</th>
              <th class="fw-bolder">Entity Details</th>
              <th class="fw-bolder">Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="entity in entities" :key="entity.id">
              <td class="fw-bolder">{{ entity.Entity }}</td>
              <td class="fw-bolder">{{ entity.EntityProjectDetails }}</td>
              <td>
                <div class="d-flex justify-content-end">
                  <a
                    href="#"
                    class="btn btn-outline btn-outline-dashed btn-outline-secondary btn-active-light-secondary fw-bolder me-2"
                    @click="showModal(true, entity)"
                  >
                    <i class="ki ki-pencil fs-3"></i>
                    <span class="indicator-label">Edit</span>
                  </a>
                  <a
                    href="#"
                    class="btn btn-outline btn-outline-dashed btn-outline-secondary btn-active-light-secondary me-2"
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
    <div
      v-if="isModalOpen"
      class="modal bg-body fade show d-block"
      id="kt_modal_2"
    >
      <div class="modal-dialog modal-fullscreen">
        <div class="modal-content shadow-none">
          <div class="modal-header">
            <h5 class="modal-title">
              {{ currentEntity.id ? "Edit Entity" : "Add Entity" }}
            </h5>
            <!--begin::Close-->
            <div
              class="btn btn-icon btn-sm btn-active-light-primary ms-2"
              @click="showModal(false, {})"
              aria-label="Close"
            >
              <i class="ki-duotone ki-cross fs-2x"
                ><span class="path1"></span><span class="path2"></span
              ></i>
            </div>
            <!--end::Close-->
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
              <!-- <button type="submit" class="btn btn-primary">
                {{ currentEntity.id ? "Update" : "Add" }} Entity
              </button> -->
            </form>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-light"
              @click="showModal(false, {})"
            >
              Close
            </button>
            <button type="button" class="btn btn-primary" @click="submitForm">
              {{ currentEntity.id ? "Update" : "Add" }} Entity
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import pb from "../../pocketbase";
import Swal from "sweetalert2";
import FullScreenLoader, {
  isLoading,
} from "../../components/FullScreenLoader.vue";

export default {
  name: "EntityManagement",
  components: {
    FullScreenLoader,
  },
  data() {
    return {
      entities: [],
      currentEntity: {
        Entity: "",
        EntityID: "",
        EntityProjectDetails: "",
      },
      isModalOpen: false,
    };
  },
  methods: {
    initDataTable() {
      // this.$nextTick(() => {
      //   if ($.fn.DataTable.isDataTable("table")) {
      //     $("table").DataTable().clear().destroy();
      //   }
      //   $(document).ready(function () {
      //     $("table").DataTable({
      //       responsive: true,
      //       dom: "Bfrtip",
      //       pageLength: 5, // Set default number of records per page
      //       buttons: ["copy", "csv", "excel", "pdf", "print"],
      //     });
      //   });
      // });
    },
    async fetchEntities() {
      isLoading.value = true;
      try {
        const resultList = await pb.collection("mpa_entities").getFullList({
          sort: "-created",
        });
        this.entities = resultList;
      } catch (error) {
        console.error("Error fetching entities:", error);
        Swal.fire(
          "Error",
          "Error fetching entities: " + error.message,
          "error"
        );
      } finally {
        isLoading.value = false;

        this.initDataTable();
      }
    },
    showModal(open, entity) {
      this.isModalOpen = open;
      this.currentEntity = { ...entity };
      if (!this.currentEntity.EntityID) {
        this.currentEntity.EntityID = this.generateEntityID();
      }
    },
    generateEntityID() {
      return Math.floor(Date.now() / 1000); // Unix timestamp in seconds
    },
    async submitForm() {
      console.log("Form Data:", this.currentEntity);
      isLoading.value = true;
      try {
        if (this.currentEntity.id) {
          await pb
            .collection("mpa_entities")
            .update(this.currentEntity.id, this.currentEntity);
        } else {
          await pb.collection("mpa_entities").create(this.currentEntity);
        }
        Swal.fire(
          "Success",
          "Entity has been processed successfully",
          "success"
        );
        this.fetchEntities();
      } catch (error) {
        console.error("Error submitting form:", error);
        Swal.fire("Error", "Error submitting form: " + error.message, "error");
      } finally {
        this.showModal(false, {});
        isLoading.value = false;
      }
    },
    async deleteEntity(id) {
      isLoading.value = true;
      try {
        await pb.collection("mpa_entities").delete(id);
        Swal.fire("Deleted!", "Your entity has been deleted.", "success");
        this.fetchEntities();
      } catch (error) {
        console.error("Error deleting entity:", error);
        Swal.fire("Error", "Error deleting entity: " + error.message, "error");
      } finally {
        isLoading.value = false;
      }
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
  },
  created() {
    this.fetchEntities();
  },
};
</script>

<!-- <style scoped>
.modal.fade.show {
  display: block;
  background: rgba(0, 0, 0, 0.5);
}
</style> -->
