import React from 'react';
import { connect } from 'react-redux';
import PokemonDetail from './pokemon_detail';
import { requestPokemon } from '../../actions/pokemon_actions';

const mapStateToProps = (state) => ({
  displayPokemon: state.displayPokemon
});


export default connect(mapStateToProps, null)(PokemonDetail);
