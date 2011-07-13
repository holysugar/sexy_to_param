# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Article < ActiveRecord::Base
  sexy_to_param
end

class ArticleUsingTitle < ActiveRecord::Base
  set_table_name 'articles'
  sexy_to_param :title
end

describe Article do
  before(:all) {
    setup_db
    Article.create(:slug => "myslug", :title => "/About @twitter and #github")
    Article.create(:slug => "japanese", :title => "日本語")
  }
  after(:all) { teardown_db }

  describe "default options" do
    let(:article) { Article.first }
    subject { article }

    its(:to_param) { should == "1-myslug" }
  end

  context "with column name option" do
    subject { ArticleUsingTitle.first }
    its(:to_param) { should == "1-About-twitter-and-github" }
  end

  context "needs to escape, such as Japanese letters" do
    subject { ArticleUsingTitle.last }
    its(:to_param) { should == "2-%E6%97%A5%E6%9C%AC%E8%AA%9E" }
  end

end
