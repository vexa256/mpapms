// src/services/pocketbase.js
import PocketBase from 'pocketbase';
import Swal from 'sweetalert2';
import { isLoading } from '/src/components/FullScreenLoader.vue'; // Adjust the path as necessary

const pb = new PocketBase('https://pocketbase.ecsahc.com');

// Request interceptor to show loading screen
pb.beforeSend = function (url, options) {
  isLoading.value = true;
  return { url, options };
};

// Response interceptor to hide loading screen and handle errors
pb.afterReceive = function (response) {
  isLoading.value = false;
  if (!response.ok) {
    const error = new Error(response.statusText);
    console.error("Error:", error.message);
    Swal.fire("Error", "Error: " + error.message, "error");
  }
  return response;
};

// Error interceptor to handle request errors
pb.afterError = function (error) {
  isLoading.value = false;
  console.error('Request error:', error);
  Swal.fire({
    title: 'Error',
    text: `Failed to send request: ${error.message}. Please check the console for more details.`,
    icon: 'error',
    confirmButtonText: 'OK'
  });
  return Promise.reject(error);
};

export default pb;
