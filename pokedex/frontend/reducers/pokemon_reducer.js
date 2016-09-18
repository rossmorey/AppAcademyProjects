import { POKEMON_CONSTANTS }from '../actions/pokemon_actions';
import { merge } from 'lodash';

export const PokemonReducer = (oldState = {pokemon: [], displayPokemon: {}}, action) => {
  let newState;
  switch (action.type) {
    case POKEMON_CONSTANTS.RECEIVE_ALL_POKEMON:
      newState = merge({}, oldState, {pokemon: action.allPokemon});
      return newState;
    case POKEMON_CONSTANTS.RECEIVE_POKEMON:
      newState = merge({}, oldState, {displayPokemon: action.pokemon});
      return newState;
    default:
      return oldState;
  }
};
