import React from 'react';
import { connect } from 'react-redux';
import PokemonIndex from './pokemon_index';
import { requestAllPokemon } from '../../actions/pokemon_actions';

const mapStateToProps = (state) => ({
  pokemon: state.pokemon
});


export default connect(mapStateToProps, null)(PokemonIndex);
