// src/services/pocketbase.js
import PocketBase from 'pocketbase';
import Swal from 'sweetalert2';
import { isLoading } from './components/FullScreenLoader.vue';

const pb = new PocketBase('https://pocketbase.ecsahc.com');

// Request interceptor to show loading screen
pb.beforeSend = function (url, method, data) {
  isLoading.value = true;
  return { url, method, data };
};

// Response interceptor to hide loading screen and handle errors
pb.afterSend = function (response, error) {
  isLoading.value = false;
  if (error) {
    console.error("Error:", error.message);
    Swal.fire("Error", "Error: " + error.message, "error");
  }
  return response;
};

export default pb;
