import { createClient } from '@supabase/supabase-js'
import type { SupabaseClient } from '@supabase/supabase-js'

// Server-side only — bypassa RLS. NUNCA importar em client. Lazy init via Proxy.
let _client: SupabaseClient | null = null
function getClient(): SupabaseClient {
  if (!_client) {
    _client = createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!,
      { auth: { persistSession: false, autoRefreshToken: false } }
    )
  }
  return _client
}
export const supabaseAdmin = new Proxy({} as SupabaseClient, {
  get(_t, prop) { return Reflect.get(getClient(), prop) },
})
