<template>
  <div id="container">
    <strong>{{ props.name }}</strong>
    <p>Explore <a target="_blank" rel="noopener noreferrer" href="https://ionicframework.com/docs/components">UI Components</a></p>
    <template v-for="personn in props.personns" :key="personn.name">
      <p >{{ personn.name }} - {{ personn.age }} ans - {{ personn.status }}</p>
     <button v-if="props.plateform.includes('mobile') && personn.status === 'En attente'">Démarrer</button>
     <button v-else-if="props.plateform.includes('mobile') && personn.status === 'En cours'">Arréter</button>
    </template>
  </div>
</template>

<script setup lang="ts">
import { defineProps } from 'vue';

const props = defineProps<{
  name: string;
  personns: {
    name: string;
    age: number;
    status: "En attente" | "En cours" | "Terminé"
  }[];
  plateform: ("mobile" | "ios" | "ipad" | "iphone" | "android" | "phablet" | "tablet" | "cordova" | "capacitor" | "electron" | "pwa" | "mobileweb" | "desktop" | "hybrid")[];
}>();
</script>

<style scoped>
#container {
  text-align: center;
  position: absolute;
  left: 0;
  right: 0;
  top: 50%;
  transform: translateY(-50%);
}

#container strong {
  font-size: 20px;
  line-height: 26px;
}

#container p {
  font-size: 16px;
  line-height: 22px;
  color: #8c8c8c;
  margin: 0;
}

#container a {
  text-decoration: none;
}
</style>
