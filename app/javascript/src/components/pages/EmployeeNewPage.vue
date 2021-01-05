<template>
  <employee-form-pane
    :errors="errors"
    :employee="employee"
    @submit="createEmployee"
  ></employee-form-pane>
</template>

<script>
import { ref, reactive } from "vue";
import { useRouter } from "vue-router";
import EmployeeFormPane from "@/components/organisms/EmployeeFormPane.vue";
import axios from "axios";

export default {
  name: "EmployeeNewPage",
  components: {
    EmployeeFormPane,
  },
  setup() {
    const router = useRouter();
    const employee = reactive({
      name: "",
      department: "",
      gender: "",
      birth: "",
      joined_date: "",
      payment: "",
      note: "",
    });
    const errors = ref([]);

    const createEmployee = () => {
      console.log(employee);
      if (!employee) return;
      axios
        .post("/api/v1/employees", employee)
        .then((response) => {
          let e = response.data;
          router.push({
            name: "EmployeeDetailPage",
            params: { id: e.id },
          });
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            errors.value = error.response.data.errors;
          }
        });
    };

    return { employee, errors, createEmployee };
  },
};
</script>

<style scoped>
</style>