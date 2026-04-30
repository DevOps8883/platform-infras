const express = require('express');
const app = express();

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send(
    `
    <h1 style="fontsize:40px; text-align:center; color:grey;">DCUBE CLOUD SERVICES</h1>
    <p style="fontsize:25px; text-align:center; color:red;">Welcome to the CloudWorld!</p>
  `
    );
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK' });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
