import { createStore } from 'vuex';
import pb from "/src/pocketbase.js";
import Swal from "sweetalert2";
export default createStore({
  state: {
    user: null,
  },
  mutations: {
    setUser(state, user) {
      state.user = user;
    },
  },
  actions: {
    fetchUser({ commit }, userCode) {
      // Fetch user details from PocketBase
      return pb.collection('mpa_users').getFirstListItem(`UserCode="${userCode}"`)
        .then(user => {
          commit('setUser', user);
          return user;
        })
        .catch(error => {
          throw new Error('User not found');
        });
    },
  },
  getters: {
    user: state => state.user,
  },
});
