<template>
  <div class="container px-5 py-5">
    <FullScreenLoader />
    <div class="card-body shadow-lg pt-3 bg-light table-responsive px-5 py-5">
      <div class="row">
        <div class="col-md-12">
          <form @submit.prevent="fetchIndicators">
            <div class="mb-3 col-md-12 py-5 my-5">
              <label class="px-5 my-5 required form-label">
                Select Entity To Attach Indicators To
              </label>
              <select
                v-model="selectedEntity"
                class="form-select py-5 my-5 form-select-solid"
                required
              >
                <option></option>
                <option
                  v-for="entity in entities"
                  :key="entity.EntityID"
                  :value="entity.EntityID"
                >
                  {{ entity.Entity }}
                </option>
              </select>
            </div>
            <div class="float-end my-3">
              <button class="btn btn-danger btn-sm shadow-lg" type="submit">
                Next
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import pb from '../../pocketbase';
import Swal from 'sweetalert2';
import FullScreenLoader, { isLoading } from '../../components/FullScreenLoader.vue';

export default {
  name: "EntitySelection",
  components: {
    FullScreenLoader
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
        const resultList = await pb.collection('mpa_entities').getFullList({
          sort: '-created',
        });
        this.entities = resultList;
      } catch (error) {
        console.error("Error fetching entities:", error.message);
        Swal.fire("Error", "Error fetching entities: " + error.message, "error");
      } finally {
        isLoading.value = false;
      }
    },
    fetchIndicators() {
      if (this.selectedEntity) {
        console.log("Selected EntityID:", this.selectedEntity);
        this.$router.push({
          name: "MgtIndicators",
          query: { entityid: this.selectedEntity },
        });
      } else {
        console.error("No entity selected");
        Swal.fire("Warning", "No entity selected", "warning");
      }
    },
  },
  created() {
    this.fetchEntities();
  },
};
</script>

