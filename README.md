# 🚀 Cloudflare Workflows Starter Template - E-Commerce Edition

[![Deploy to Cloudflare](https://deploy.workers.cloudflare.com/button)](https://deploy.workers.cloudflare.com/?url=https://github.com/cloudflare/templates/tree/main/workflows-starter-template)

---

## 🎨 Vue d'ensemble

**Un template e-commerce production-ready démontrant Cloudflare Workflows** avec mises à jour en temps réel via WebSockets et Durable Objects. Parfait pour construire des boutiques en ligne haute performance avec traitement de commandes, notifications en direct, et gestion d'états complexes.

### ✨ Cas d'usage

- 🛒 **E-commerce** - Gestion de commandes avec approvals
- 📦 **Fulfillment** - Suivi d'inventaire en temps réel
- 💳 **Paiements** - Workflows multi-étapes sécurisés
- 📢 **Notifications** - Updates live avec WebSocket
- ⚙️ **Automatisation** - Tâches asynchrones et durables

---

## 📋 Caractéristiques principales

### ⚡ Performance en temps réel
- Communication WebSocket bidirectionnelle
- Updates instantanées sans rafraîchissement
- Latence ultra-faible grâce à Cloudflare Edge

### 🔄 Workflows robustes
- **Étapes durables** - Gestion automatique des défaillances
- **Délais temporels** - `step.sleep()` pour les tâches planifiées
- **Approbations interactives** - `step.waitForEvent()` pour interventions humaines
- **Persistance d'état** - Données sauvegardées via Durable Objects

### 📦 Stack moderne
```
Frontend: React 19 + TypeScript + Tailwind CSS
Backend: Cloudflare Workers + Workflows + Durable Objects
Communication: WebSocket (temps réel) + REST API
Infrastruture: Zéro serveur, scalabilité illimitée
```

---

## 🎯 Résultat visuel

![Cloudflare Workflows Starter Template](assets/template-screenshot.png)

---

## 🏗️ Architecture

### Frontend (React)
```
src/
  App.tsx                    Composant racine
  main.tsx                   Point d'entrée
  types.ts                   Types TypeScript partagés
  index.css                  Styles globaux
  components/
    WorkflowDiagram.tsx      Visualisation des étapes
    CodeDisplay.tsx          Affichage du code en direct
    BackgroundDots.tsx       UI décoratif
  hooks/
    useWorkflowWebSocket.ts  Gestion WebSocket temps réel
```

### Backend (Cloudflare)
```
worker/
  index.ts                   Gestionnaire principal + Routes API
  workflow.ts                Logique Workflows (étapes durables)
  durable-object.ts          WebSocket + Gestion d'état persistant
```

### Points d'entrée API

| Route | Méthode | Description |
|-------|---------|-------------|
| `/api/workflow/start` | POST | Créer une instance de workflow |
| `/api/workflow/status/:id` | GET | Récupérer le statut |
| `/api/workflow/event/:id` | POST | Envoyer un événement (approbation) |
| `/ws` | WebSocket | Connexion temps réel |

---

## 🚀 Démarrage rapide

### Prérequis
- Node.js 18+
- Compte Cloudflare (gratuit)
- Wrangler CLI

### Installation

```bash
# Cloner le repo
git clone https://github.com/blockolepitchitchi4-create/kag-ecommerce3
cd kag-ecommerce3

# Installer les dépendances
npm install
```

### Développement local

```bash
npm run dev
```

Visitez `http://localhost:5173` pour voir le template interactif.

### Déploiement sur Cloudflare

```bash
# Build
npm run build

# Déployer
npm run deploy
```

Votre application sera disponible sur `your-project.workers.dev` 🎉

---

## 📚 Flux de travail exemple

Le template démontre un workflow avec 4 étapes :

```
1. Process Data (1s)
   ↓
2. Wait 2 Seconds (délai)
   ↓
3. Wait for Approval (pause interactive)
   ↓
4. Final (finalisation)
```

**À adapter** : Remplacement des étapes par votre logique métier (commandes, paiements, etc.)

---

## 💡 Cas d'usage e-commerce

### Exemple: Workflow de commande

```typescript
export class OrderWorkflow extends WorkflowEntrypoint {
  async run(event, step) {
    // 1. Valider les données
    const order = await step.do("validate-order", () => {
      return validateOrder(event.payload);
    });

    // 2. Traiter le paiement
    const payment = await step.do("process-payment", () => {
      return stripe.charges.create({...});
    });

    // 3. Attendre approbation fulfillment
    const approval = await step.waitForEvent("fulfillment-approval", {
      timeout: "24 hours"
    });

    // 4. Envoyer au warehouse
    if (approval.payload.approved) {
      await step.do("ship-order", () => {
        return warehouse.createShipment(order.id);
      });
    }
  }
}
```

---

## 🔗 Ressources

- [📖 Cloudflare Workflows Documentation](https://developers.cloudflare.com/workflows)
- [💾 Durable Objects Documentation](https://developers.cloudflare.com/durable-objects)
- [⚙️ Workers Documentation](https://developers.cloudflare.com/workers)
- [🎓 Tutoriels Cloudflare](https://developers.cloudflare.com/tutorials)

---

## 📦 Commandes utiles

```bash
# Vérifier la syntaxe
npm run check

# Linter
npm run lint

# Tests
npm run test

# Build uniquement
npm run build

# Preview de production
npm run preview

# Générer les types Cloudflare
npm run cf-typegen
```

---

## 💰 Licence & Utilisation commerciale

Ce template est prêt pour la production et peut être utilisé commercialement.
Parfait pour :
- 🛍️ Vendre en tant que template
- 🏢 Utiliser pour des clients
- 📚 Inclure dans des cours/formations
- 🚀 Déployer en tant que SaaS

---

## 🤝 Support

Des questions ? Consultez :
- [Issues GitHub](https://github.com/blockolepitchitchi4-create/kag-ecommerce3/issues)
- [Communauté Cloudflare](https://community.cloudflare.com)
- [Documentation officielle](https://developers.cloudflare.com)

---

**Créé avec ❤️ par blockolepitchitchi4-create**
