import React, { PropTypes } from 'react';

export default class Footer extends React.Component {
  render () {
    return (
      <footer className="main-footer">
        <div className="pull-right hidden-xs">
          <b>{I18n.t("footer.version")}</b> 2.0.0
        </div>
        <strong>{I18n.t("footer.coppy_right")}
          <a href="http://almsaeedstudio.com"></a>.
        </strong>
        {I18n.t("footer.all_right")}
      </footer>
    )
  }
}
