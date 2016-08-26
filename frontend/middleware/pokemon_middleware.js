import * as ACTIONS from '../actions/pokemon_actions';
import { fetchAllPokemon, fetchSinglePokemon } from '../util/api_util';

const PokemonMiddleware = ( { dispatch }) => next => action => {
  switch (action.type) {
    case ACTIONS.POKEMON_CONSTANTS.REQUEST_ALL_POKEMON:
      fetchAllPokemon((data) => (dispatch(ACTIONS.receiveAllPokemon(data))));
      break;
    case ACTIONS.POKEMON_CONSTANTS.REQUEST_POKEMON:
      fetchSinglePokemon(action.pokemonId, (data) => (dispatch(ACTIONS.receivePokemon(data))));
      break;
    default:
      next(action);
  }
};

export default PokemonMiddleware;
