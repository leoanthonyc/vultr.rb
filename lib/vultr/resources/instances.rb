module Vultr
  class InstancesResource < Resource
    def list(**params)
      response = get_request("instances", params: params)
      Collection.from_response(response, key: "instances", type: Instance)
    end

    def retrieve(id)
      Instance.new get_request("instances/#{id}").body
    end

    def create(**attributes)
      Instance.new post_request("instances", body: attributes).body.dig("instance")
    end

    def update(id, **attributes)
      patch_request("instances/#{id}", body: attributes)
    end

    def delete(id)
      delete_request("instances/#{id}")
    end

    def start(id)
      post_request("instances/#{id}/start")
    end

    def reboot(id)
      post_request("instances/#{id}/reboot")
    end

    def reinstall(id)
      Instance.new post_request("instances/#{id}/reinstall").body.dig("instance")
    end

    def restore(id, **attributes)
      Object.new post_request("instances/#{id}/restore", attributes).body.dig("status")
    end

    def halt(id)
      post_request("instances/#{id}/halt")
    end

    def bandwidth(id)
      Object.new get_request("instances/#{id}/bandwidth").body.dig("bandwidth")
    end

    def neighbors(id)
      Object.new get_request("instances/#{id}/neighbors").body.dig("neighbors")
    end

    def user_data(id)
      Object.new get_request("instances/#{id}/user-data").body.dig("user_data")
    end

    def upgrades(id, **params)
      Object.new get_request("instances/#{id}/upgrades", params: params).body.dig("upgrades")
    end

    def list_ipv4(id, **params)
      response = get_request("instances/#{id}/ipv4", params: params)
      Collection.from_response(response, key: "ipv4s", type: Object)
    end

    def create_ipv4(id, **params)
      Object.new post_request("instances/#{id}/ipv4", body: params).body.dig("ipv4")
    end

    def delete_ipv4(id, ipv4:)
      delete_request("instances/#{id}/ipv4/#{ipv4}")
    end

    def create_ipv4_reverse(id, **params)
      post_request("instances/#{id}/ipv4/reverse", body: params)
    end

    def set_default_reverse_dns_entry(id, **params)
      post_request("instances/#{id}/ipv4/reverse/default", body: params)
    end

    def list_ipv6(id, **params)
      response = get_request("instances/#{id}/ipv6", params: params)
      Collection.from_response(response, key: "ipv6s", type: Object)
    end

    def ipv6_reverse(id)
      response = get_request("instances/#{id}/ipv6")
      Collection.from_response(response, key: "reverse_ipv6s", type: Object)
    end

    def create_ipv6_reverse(id, **params)
      post_request("instances/#{id}/ipv6/reverse", body: params)
    end

    def delete_ipv6_reverse(id, ipv6:)
      delete_request("instances/#{id}/ipv6/reverse/#{ipv6}")
    end

    def list_private_networks(id, **params)
      response = get_request("instances/#{id}/private-networks", params: params)
      Collection.from_response(response, key: "private_networks", type: PrivateNetwork)
    end

    def attach_private_network(id, network_id:)
      post_request("instances/#{id}/private-networks/attach", body: {network_id: network_id})
    end

    def detach_private_network(id, network_id:)
      post_request("instances/#{id}/private-networks/detach", body: {network_id: network_id})
    end

    def iso(id)
      Object.new get_request("instances/#{id}/iso").body.dig("iso_status")
    end

    def attach_iso(id, iso_id:)
      Object.new post_request("instances/#{id}/iso/attach", body: {iso_id: iso_id}).body.dig("iso_status")
    end

    def detach_iso(id, iso_id:)
      Object.new post_request("instances/#{id}/iso/detach", body: {iso_id: iso_id}).body.dig("iso_status")
    end

    def backup_schedule(id)
      Object.new get_request("instances/#{id}/backup-schedule").body.dig("backup_schedule")
    end

    def set_backup_schedule(id, **attributes)
      post_request("instances/#{id}/backup-schedule", body: attributes)
    end

    # Bulk operations
    def halt_instances(ids)
      post_request("instances/halt", body: {instance_ids: Array(ids)})
    end

    def reboot_instances(ids)
      post_request("instances/reboot", body: {instance_ids: Array(ids)})
    end

    def start_instances(ids)
      post_request("instances/start", body: {instance_ids: Array(ids)})
    end
  end
end
