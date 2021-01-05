<template>
  <table>
    <tbody>
      <tr>
        <th>ID</th>
        <th>name</th>
        <th>department</th>
        <th>gender</th>
        <th>actions</th>
      </tr>
      <tr v-for="e in employees" :key="e.id">
        <td>
          <router-link
            :to="{ name: 'EmployeeDetailPage', params: { id: e.id } }"
            >{{ e.id }}</router-link
          >
        </td>
        <td>{{ e.name }}</td>
        <td>{{ e.department }}</td>
        <td>{{ e.gender }}</td>
        <td>
          <button
            @click="
              deleteTarget = e.id;
              showModal = true;
            "
          >
            Delete
          </button>
        </td>
      </tr>
    </tbody>
  </table>
  <modal
    v-if="showModal"
    @cancel="showModal = false"
    @ok="
      deleteEmployee();
      showModal = false;
    "
  >
    <template v-slot:body>
      <p>Are you sure?</p>
    </template>
  </modal>
</template>

<script>
import { ref, onMounted } from "vue";
import axios from "axios";

import Modal from "@/components/organisms/Modal.vue";

export default {
  name: "EmployeeIndexPage",
  components: {
    Modal,
  },
  setup() {
    const api = "/api/v1/employees/";
    const employees = ref([]);
    const showModal = ref(false);
    const errors = ref([]);

    const fetchEmployees = () => {
      axios.get(api).then((response) => (employees.value = response.data));
    };

    onMounted(() => {
      fetchEmployees();
    });

    // delete
    const deleteTarget = ref(-1);

    const deleteEmployee = () => {
      if (deleteTarget.value <= 0) {
        console.warn("deleteTarget should be grater than zero.");
        return;
      }
      axios
        .delete(api + deleteTarget.value)
        .then((response) => {
          deleteTarget.value = -1;
          fetchEmployees();
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            errors.value = error.response.data.errors;
          }
        });
    };

    return {
      employees,
      showModal,
      errors,
      deleteTarget,
      deleteEmployee,
    };
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>