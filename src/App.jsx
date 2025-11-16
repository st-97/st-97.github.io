import React from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import AngillLaunchPage from "./pages/AngillLaunchPage";

const AppContent = () => {
  return (
    <Routes>
      <Route path="/" element={<AngillLaunchPage />} />
    </Routes>
  );
};

const App = () => {
  return (
    <BrowserRouter>
      <AppContent />
    </BrowserRouter>
  );
};

export default App;
