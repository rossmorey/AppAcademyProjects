export const POKEMON_CONSTANTS = {
  RECEIVE_ALL_POKEMON : 'RECEIVE_ALL_POKEMON',
  REQUEST_ALL_POKEMON : 'REQUEST_ALL_POKEMON',
  RECEIVE_POKEMON : "RECEIVE_POKEMON",
  REQUEST_POKEMON : "REQUEST_POKEMON"
};

export const receiveAllPokemon = (allPokemon) => {
  return {
  type: POKEMON_CONSTANTS.RECEIVE_ALL_POKEMON,
  allPokemon
};
};

export const requestAllPokemon = () => ({
  type: POKEMON_CONSTANTS.REQUEST_ALL_POKEMON
});

export const receivePokemon = (pokemon) => {
  return {
  type: POKEMON_CONSTANTS.RECEIVE_POKEMON,
  pokemon
};
};

export const requestPokemon = (pokemonId) => ({
  type: POKEMON_CONSTANTS.REQUEST_POKEMON,
  pokemonId
});
