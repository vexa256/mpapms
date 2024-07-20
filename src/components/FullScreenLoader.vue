<template>
  <div v-if="isLoading" class="fullscreen-loader">
    <div class="spinner-border text-primary" role="status">
      <span class="visually-hidden">Loading...</span>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";

export const isLoading = ref(false);

export default {
  setup() {
    return {
      isLoading,
    };
  },
};
</script>

<style scoped>
.fullscreen-loader {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(255, 255, 255, 0.8);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;
}
</style>
