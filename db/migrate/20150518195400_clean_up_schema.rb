class CleanUpSchema < ActiveRecord::Migration[4.2]
  def change
  	drop_table "abouts"
  	remove_column "alma_maters", "year"
  	remove_column "alumni", "year"
  	remove_column "faculties", "summary"
  	remove_column "faculties", "first_year"
  	remove_column "faculties", "last_year"
  	remove_column "faculties", "current"
  	remove_column "faculties", "visible"
  	remove_column "faculties", "title"
  	remove_column "faculties", "website"
  	remove_column "palettes", "name"
  	remove_column "logos", "name"
  	remove_column "patterns", "name"
  	remove_column "posts", "category"
  	remove_column "resources", "category"
  	remove_column "resources", "caption"
  	remove_column "resources", "type_id"
  	remove_column "resources", "visible"
  	remove_column "works", "name"
  	remove_column "works", "caption"
  	remove_column "works", "visible"
  	remove_column "works", "orientation"
  	remove_column "works", "width"
  	remove_column "works", "height"
  end
end
