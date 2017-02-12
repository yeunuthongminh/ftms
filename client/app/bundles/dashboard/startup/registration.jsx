import ReactOnRails from 'react-on-rails';

import Header from '../components/header';
import Sidebar from '../components/sidebar';
import Footer from '../components/footer';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  Header,
  Sidebar,
  Footer,
});
