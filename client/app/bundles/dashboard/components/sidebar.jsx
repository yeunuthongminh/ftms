import React, { PropTypes } from 'react';

export default class Sidebar extends React.Component {
  render () {
    return (
      <aside className="main-sidebar">
        <section className="sidebar">
          <div className="user-panel">
            <div className="pull-left image">
              <img src="http://www.w3schools.com/css/trolltunga.jpg"
                className="img-circle" alt={I18n.t("header.user_image_alt")} />
            </div>
            <div className="pull-left info">
              <p>{I18n.t("header.test_name")}</p>
              <a href="#">
                <i className="fa fa-circle text-success"></i>
                {I18n.t("header.test_online")}
              </a>
            </div>
          </div>
          <ul className="sidebar-menu">
            <li className="header">{I18n.t("sidebar.main_nav")}</li>
            <li className="active treeview">
              <a href="#">
                <i className="fa fa-dashboard"></i>
                <span>{I18n.t("sidebar.dashboard")}</span>
                <span className="pull-right-container">
                  <i className="fa fa-angle-left pull-right"></i>
                </span>
              </a>
              <ul className="treeview-menu">
                <li className="active">
                  <a href="index.html">
                    <i className="fa fa-circle-o"></i>
                    {I18n.t("sidebar.dashboard")}
                  </a>
                </li>
                <li>
                  <a href="index2.html">
                    <i className="fa fa-circle-o"></i>
                    {I18n.t("sidebar.dashboard")}
                  </a>
                </li>
              </ul>
            </li>
          </ul>
        </section>
      </aside>
    );
  }
}
