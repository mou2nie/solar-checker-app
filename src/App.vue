<template>
  <img alt="Vue logo" src="./assets/logo.png">
  <SolarDataInput msg="Willkommen zur Solar Checker App"/>
</template>

<script>
import SolarDataInput from './components/SolarDataInput.vue'

export default {
  name: 'App',
  components: {
    SolarDataInput
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
