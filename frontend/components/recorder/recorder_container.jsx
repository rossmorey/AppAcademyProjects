import { connect } from 'react-redux';
import Recorder from './recorder';

const mapStateToProps = (state) => ({
  tracks: state.tracks,
  isRecording: state.isRecording
});

const mapDispatchToProps = (dispatch) => {

};

connect ()
