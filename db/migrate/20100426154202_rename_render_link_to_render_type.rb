class RenameRenderLinkToRenderType < ActiveRecord::Migration
  def self.up
    render_link = Setting.plugin_redmine_checkout.delete 'render_link'
    unless  render_link.nil?
      Setting.plugin_redmine_checkout['render_type'] = (render_link == 'true' ? 'link' : 'url')
      Setting.plugin_redmine_checkout = Setting.plugin_redmine_checkout
    end
    
    add_column :repositories, :render_type, :string, :default => 'url', :null => false
    
    Repository.where(:render_link => true).update_all(:render_type => 'link')
    Repository.where('render_link != ?', true).update_all(:render_type => 'url')
    
    remove_column :repositories, :render_link
  end
  
  def self.down
    render_type = Setting.plugin_redmine_checkout.delete 'render_type'
    unless  render_type.nil?
      Setting.plugin_redmine_checkout['render_link'] = (render_type == 'link' ? 'true' : 'false')
      Setting.plugin_redmine_checkout = Setting.plugin_redmine_checkout
    end
    
    add_column :repositories, :render_link, :boolean, :null => true
    
    Repository.where(:render_type => 'link').update_all(:render_link => true)
    Repository.where(':render_type != ?', 'link').update_all(:render_link => false)
    
    remove_column :repositories, :render_type
  end
end
