import { handler as createUseAccount } from "./useAccount";

const DEFAULT_HOOKS = {
  useAccount: () => ({account: null})
}

export const setupHooks = web3 => {

  return {
    useAccount: createUseAccount(web3)
  }
}