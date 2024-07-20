<template>
  <div class="container px-5 py-5">
    <div class="card-body shadow-lg pt-3 bg-light table-responsive px-5 py-5">
      <div class="row">
        <div class="col-md-12">
          <form @submit.prevent="fetchIndicators">
            <div class="mb-3 col-md-12 py-5 my-5">
              <label class="px-5 my-5 required form-label"
                >Select Entity To Attach Indicators To</label
              >
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
export default {
  name: "EntitySelection",
  data() {
    return {
      entities: [],
      selectedEntity: null,
    };
  },
  methods: {
    fetchEntities() {
      this.$axios
        .post(`${window.SERVER_URL}MassFetch`, {
          TableName: "entities",
          ExcludeColumns: [], // Ensure ExcludeColumns is passed as an array
        })
        .then((response) => {
          this.entities = response.data.data;
        })
        .catch((error) => {
          console.error("Error fetching entities:", error);
        });
    },
    fetchIndicators() {
      if (this.selectedEntity) {
        console.log("Selected EntityID:", this.selectedEntity); // Debug log
        this.$router.push({
          name: "MgtIndicators",
          query: { EntityID: this.selectedEntity },
        });
      } else {
        console.error("No entity selected");
      }
    },
  },
  created() {
    this.fetchEntities();
  },
};
</script>
