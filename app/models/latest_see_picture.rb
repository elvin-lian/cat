class LatestSeePicture < ActiveRecord::Base
  attr_accessible :latest_see_id, :pic, :title, :rank

  belongs_to :latest_see

  mount_uploader :pic, PictureUploader

  def full_pic_url
    if self.pic and self.pic.url
      Rails.application.config.action_controller.asset_host + self.pic.url
    else
      ''
    end
  end


  def to_jq_upload
    {
        id: self.id,
        rank: self.rank,
        name: read_attribute(:pic),
        created_at: self.created_at.localtime.strftime('%Y-%m-%d %H:%M'),
        size: self.pic.size,
        url: self.pic.url,
        thumbnail_url: self.pic.thumb.url,
        delete_url: "/admin/latest_sees/#{self.latest_see_id}/pictures/#{self.id}",
        picture_id: self.id,
        delete_type: "DELETE"
    }
  end

end
