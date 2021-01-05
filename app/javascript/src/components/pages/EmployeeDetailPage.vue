<template>
  <dl>
    <dt>ID</dt>
    <dd>{{ employee.id }}</dd>
    <dt>Name</dt>
    <dd>{{ employee.name }}</dd>
    <dt>Department</dt>
    <dd>{{ employee.department }}</dd>
    <dt>Gender</dt>
    <dd>{{ employee.gender }}</dd>
    <dt>Birth</dt>
    <dd>{{ employee.birth }}</dd>
    <dt>Joined Date</dt>
    <dd>{{ employee.joined_date }}</dd>
    <dt>Payment</dt>
    <dd>{{ employee.payment }}</dd>
    <dt>Note</dt>
    <dd>{{ employee.note }}</dd>
  </dl>
</template>

<script>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import axios from "axios";

export default {
  name: "EmployeeDetailPage",
  setup() {
    const api = "/api/v1/employees/";
    const { id } = useRoute().params; //object
    const employee = ref({});

    const fetchEmployee = () => {
      axios.get(api + id).then((response) => (employee.value = response.data));
      console.log(employee);
    };

    onMounted(() => {
      fetchEmployee();
    });

    return { employee };
  },
};
</script>

<style scoped>
</style>
