<template>
  <form>
    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li>
          <p color="red">{{ e }}</p>
        </li>
      </ul>
    </div>
    <div>
      <label>Name</label>
      <input v-model="employee.name" type="text" />
    </div>
    <div>
      <label>Department</label>
      <input v-model="employee.department" type="text" />
    </div>
    <div>
      <label>Gender</label>
      <select v-model="employee.gender">
        <option>other</option>
        <option>male</option>
        <option>female</option>
      </select>
    </div>
    <div>
      <label>Birth</label>
      <input v-model="employee.birth" type="date" />
    </div>
    <div>
      <label>Joined Date</label>
      <input v-model="employee.joined_date" type="date" />
    </div>
    <div>
      <label>Payment</label>
      <input v-model="employee.payment" type="number" min="0" />
    </div>
    <div>
      <label>Note</label>
      <input v-model="employee.note" type="text" />
    </div>
    <button @click.prevent="$emit('submit')">Commit</button>
  </form>
</template>
<script>
export default {
  props: {
    employee: {
      type: Object,
    },
    errors: {
      type: Array,
    },
  },
};
</script>

<style>
</style>
