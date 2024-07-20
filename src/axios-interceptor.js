import axios from 'axios';
import Swal from 'sweetalert2';
import { isLoading } from './components/FullScreenLoader.vue';

// Create an Axios instance
const axiosInstance = axios.create();

// Add a request interceptor
axiosInstance.interceptors.request.use(
    config => {
        isLoading.value = true; // Show loader
        return config;
    },
    error => {
        isLoading.value = false; // Hide loader
        return Promise.reject(error);
    }
);

// Add a response interceptor
axiosInstance.interceptors.response.use(
    response => {
        isLoading.value = false; // Hide loader
        return response;
    },
    error => {
        isLoading.value = false; // Hide loader
        handleAxiosError(error);
        return Promise.reject(error);
    }
);

function handleAxiosError(error) {
    if (error.response) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx
        console.error('Response error:', {
            status: error.response.status,
            data: error.response.data,
            headers: error.response.headers,
        });
        Swal.fire('Error', `Server responded with status ${error.response.status}: ${error.response.data.message || 'Unknown error'}`, 'error');
    } else if (error.request) {
        // The request was made but no response was received
        console.error('Request error:', error.request);
        Swal.fire('Error', 'No response received from the server. Please try again later.', 'error');
    } else {
        // Something happened in setting up the request that triggered an Error
        console.error('General error:', error.message);
        Swal.fire('Error', `An error occurred: ${error.message}`, 'error');
    }
}

export default axiosInstance;