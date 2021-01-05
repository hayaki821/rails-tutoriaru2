<template>
  <employee-form-pane
    :errors="errors"
    :employee="employee"
    @submit="updateEmployee"
  ></employee-form-pane>
</template>

<script>
import { ref, onMounted } from "vue";
import { useRouter, useRoute } from "vue-router";
import axios from "axios";
import EmployeeFormPane from "@/components/organisms/EmployeeFormPane.vue";

export default {
  name: "EmployeeEditPage",
  components: {
    EmployeeFormPane,
  },

  setup() {
    const api = "/api/v1/employees/";
    const { Id } = useRoute().params; //object
    const router = useRouter();
    const employee = ref({});
    const errors = ref([]);

    const fetchEmployee = () => {
      axios.get(api + Id).then((response) => (employee.value = response.data));
    };

    onMounted(() => {
      fetchEmployee();
    });

    const updateEmployee = () => {
      console.log(employee.value);
      axios
        .patch(api + Id, employee.value)
        .then((response) => {
          router.push({
            name: "EmployeeDetailPage",
            params: { id: employee.value.id },
          });
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            errors.value = error.response.data.errors;
          }
        });
    };

    return { employee, errors, updateEmployee };
  },
};
</script>

<style scoped>
</style>