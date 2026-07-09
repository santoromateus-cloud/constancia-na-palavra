"use client";

import { useState } from "react";
import { createClient } from "@/lib/supabase";

export default function SairButton() {
  const [saindo, setSaindo] = useState(false);

  async function sair() {
    setSaindo(true);
    const supabase = createClient();
    await supabase.auth.signOut();
    window.location.href = "/";
  }

  return (
    <button className="conta-btn-sair" onClick={sair} disabled={saindo}>
      {saindo ? "Saindo…" : "Sair da conta"}
    </button>
  );
}
