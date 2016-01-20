require 'socket'

class InstitutionalHostnameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless is_institutional(value, record.organization)
      record.errors[attribute] << "is not an insitutional hostname"
    end
  end

  private
  def is_institutional(hostname, organization)
    if organization
      hostname =~ /#{organization.domain}$/
    else
      false
    end
  end
end