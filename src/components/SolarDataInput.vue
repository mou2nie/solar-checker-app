<template>
  <div class="DataInput">
    <h1>{{ msg }}</h1>
    <p>
      Dies ist der Ort, um Ihre Solaranlagendaten einzugeben.
    </p>

    <div class="input-section">
      <div class="form-group">
        <label for="ratedPower">Nennleistung der Anlage (kWp):</label>
        <input
          type="number"
          id="ratedPower"
          v-model.number="solarData.ratedPower"
          placeholder="z.B. 10.5"
          min="0"
          step="0.1"
        />
      </div>

      <div class="form-group">
        <label for="annualConsumption">Jährlicher Stromverbrauch (kWh):</label>
        <input
          type="number"
          id="annualConsumption"
          v-model.number="solarData.annualConsumption"
          placeholder="z.B. 3500"
          min="0"
        />
      </div>

      <div class="form-group">
        <label for="numberOfModules">Anzahl der Solarmodule:</label>
        <input
          type="number"
          id="numberOfModules"
          v-model.number=solarData.numberOfModules
          placeholder="z.b. 12"
          min="0"
        />
      </div>

      <div class="current-values">
        <p>Aktuelle Nennleistung: {{ solarData.ratedPower }} kWp</p>
        <p>Aktueller Verbrauch: {{ solarData.annualConsumption }} kWh</p>
        <p>Aktuelle Anzahl der Solarmodule: {{ solarData.numberOfModules }} </p>
      </div>

      <div class="results-section" v-if="hasCalculatedResults">
        <h2>Ihre Schätzung</h2>
        <p>Geschätzter jährlicher Solarertrag: {{ estimatedAnnualYield.toFixed(0) }} kWh</p>
        <p>Geschätzter Eigenverbrauch: {{ estimatedSelfConsumption.toFixed(0) }} kWh</p>
        <p>Geschätzte Einspeisung ins Netz: {{ estimatedFeedIn.toFixed(0) }} kWh</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SolarDataInput',
  props: {
    msg: String
  },
  // Hier werden die lokalen Daten der Komponente definiert
  data() {
    return {
      solarData: {
        ratedPower: null, // Nennleistung der Anlage
        annualConsumption: null, // jährlichen Stromverbrauch
        numberOfModules: null // Anzahl der Solarmodule
      }
    };
  },
  // Computed Properties, Überprüft, ob es Benutzereingaben gibt bevor die Berechnung beginnt. Verbessert UX
  computed: {
    hasCalculatedResults() {
      return (
        this.solarData.ratedPower !== null &&
        this.solarData.ratedPower > 0 &&
        this.solarData.annualConsumption !== null &&
        this.solarData.annualConsumption >= 0
        // numberOfModules ist nicht notwendig, weil ratedPower vorhanden ist.
      );
    },
    // Schätzt den jährlichen Ertrag in kWh basierend auf der Nennleistung
    // Annahme: 1 kWp erzeugt ca. 900-1000 kWh pro Jahr in Deutschland (stark vereinfacht)
    // 950 kWh/kWp wird angenommen

    estimatedAnnualYield() {
      if (this.hasCalculatedResults) {
        return this.solarData.ratedPower * 950; // kWh pro kWp
      }
      return 0;
    },
    // Schätzt Eigenverbrauch basierend auf festen Prozentsatz
    // Annahme: 30% des erzeugten Stroms ist Eigenverbrauch

    estimatedSelfConsumption() {
      if (this.hasCalculatedResults) {
        // Der Eigenverbrauch ist maximal der Jahresverbrauch oder der 30%-Anteil des Ertrags
        return Math.min(this.estimatedAnnualYield * 0.3, this.solarData.annualConsumption);
      }
      return 0;
    },
    // Schätzt die Einspeisung ins Netz
    estimatedFeedIn() {
      if (this.hasCalculatedResults) {
        return this.estimatedAnnualYield - this.estimatedSelfConsumption;
      }
      return 0;
    }
  }
}
</script>

<style scoped>
.DataInput {
  margin-top: 20px;
  text-align: center;
}
h1 {
  color: #42b983;
  margin-bottom: 20px;
}
p {
  font-size: 1.1em;
  color: #333;
}

.input-section {
  max-width: 500px;
  margin: 40px auto; /* Etwas mehr Abstand nach oben */
  padding: 25px;
  border: 1px solid #eee;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  background-color: #fdfdfd;
}

.form-group {
  margin-bottom: 20px;
  text-align: left; /* Labels und Inputs linksbündig ausrichten */
}

.form-group label {
  display: block; /* Label über dem Input platzieren */
  margin-bottom: 8px;
  font-weight: bold;
  color: #555;
}

.form-group input[type="number"] {
  width: calc(100% - 20px); /* Volle Breite mit etwas Padding-Puffer */
  padding: 12px 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  font-size: 1em;
  box-sizing: border-box; /* Padding und Border in die Breite einbeziehen */
}

.form-group input[type="number"]:focus {
  border-color: #42b983;
  outline: none;
  box-shadow: 0 0 0 2px rgba(66, 185, 131, 0.2);
}

.current-values {
  margin-top: 30px;
  padding-top: 20px;
  border-top: 1px dashed #eee;
  font-size: 0.9em;
  color: #666;
  text-align: center;
}

.results-section {
  margin-top: 40px;
  padding-top: 25px;
  border-top: 2px solid #42b983; /* Grüne Trennlinie */
  text-align: center;
}

.results-section h2 {
  color: #2c3e50;
  margin-bottom: 20px;
}

.results-section p {
  font-size: 1.2em;
  font-weight: bold;
  color: #333;
  margin-bottom: 10px;
}
</style>