import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:5000/api', // URL вашего бэкенда
});

export default api;